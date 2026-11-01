pragma solidity =0.6.6;

import '@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol';
import '@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol';
import '@uniswap/lib/contracts/libraries/FixedPoint.sol';

import '../libraries/SafeMath.sol';
import '../libraries/UniswapV2Library.sol';
import '../libraries/UniswapV2OracleLibrary.sol';

// 滑动窗口 oracle：利用在一个窗口内收集的多个 observation，提供过去
// `windowSize` 时间内的移动平均价格，精度为 `windowSize / granularity`
// 注意：这是一个单例 oracle，每组所需参数只需部署一次，这一点
// 与简单版 oracle 不同，后者必须为每个 pair 各部署一次。
contract ExampleSlidingWindowOracle {
    using FixedPoint for *;
    using SafeMath for uint;

    struct Observation {
        uint timestamp;
        uint price0Cumulative;
        uint price1Cumulative;
    }

    address public immutable factory;
    // 计算移动平均所覆盖的期望时长，例如 24 小时
    uint public immutable windowSize;
    // 每个 pair 存储的 observation 数量，即该窗口内存储多少个价格 observation。
    // granularity 从 1 开始增大时，需要更频繁地更新，但移动平均也会更精确。
    // 计算平均值所用区间的长度落在以下范围内：
    //   [windowSize - (windowSize / granularity) * 2, windowSize]
    // 例如，若窗口大小为 24 小时、granularity 为 24，则 oracle 将返回以下时间段内的
    //   平均价格：
    //   [now - [22 hours, 24 hours], now]
    uint8 public immutable granularity;
    // 该值可由 granularity 和 windowSize 推出，属于冗余，但为了节省 gas 并便于查询而存储。
    uint public immutable periodSize;

    // 从 pair 地址映射到该 pair 的价格 observation 列表
    mapping(address => Observation[]) public pairObservations;

    constructor(address factory_, uint windowSize_, uint8 granularity_) public {
        require(granularity_ > 1, 'SlidingWindowOracle: GRANULARITY');
        require(
            (periodSize = windowSize_ / granularity_) * granularity_ == windowSize_,
            'SlidingWindowOracle: WINDOW_NOT_EVENLY_DIVISIBLE'
        );
        factory = factory_;
        windowSize = windowSize_;
        granularity = granularity_;
    }

    // 返回给定时间戳所对应的 observation 的索引
    function observationIndexOf(uint timestamp) public view returns (uint8 index) {
        uint epochPeriod = timestamp / periodSize;
        return uint8(epochPeriod % granularity);
    }

    // 返回相对于当前时间而言最早的 epoch（即窗口起始处）的 observation
    function getFirstObservationInWindow(address pair) private view returns (Observation storage firstObservation) {
        uint8 observationIndex = observationIndexOf(block.timestamp);
        // 不存在溢出问题。即使 observationIndex + 1 溢出，结果仍为零。
        uint8 firstObservationIndex = (observationIndex + 1) % granularity;
        firstObservation = pairObservations[pair][firstObservationIndex];
    }

    // 更新当前时间戳所对应 observation 的 cumulative price。每个 observation 在每个 epoch 周期内
    // 最多更新一次。
    function update(address tokenA, address tokenB) external {
        address pair = UniswapV2Library.pairFor(factory, tokenA, tokenB);

        // 用空的 observation 填充数组（仅首次调用时）
        for (uint i = pairObservations[pair].length; i < granularity; i++) {
            pairObservations[pair].push();
        }

        // 获取当前周期对应的 observation
        uint8 observationIndex = observationIndexOf(block.timestamp);
        Observation storage observation = pairObservations[pair][observationIndex];

        // 每个周期（即 windowSize / granularity）只提交一次更新
        uint timeElapsed = block.timestamp - observation.timestamp;
        if (timeElapsed > periodSize) {
            (uint price0Cumulative, uint price1Cumulative,) = UniswapV2OracleLibrary.currentCumulativePrices(pair);
            observation.timestamp = block.timestamp;
            observation.price0Cumulative = price0Cumulative;
            observation.price1Cumulative = price1Cumulative;
        }
    }

    // 给定某个时间段起点和终点的 cumulative price 以及该时间段的长度，计算平均
    // 价格，结果以给定输入数量（amount in）可换得的输出数量（amount out）来表示
    function computeAmountOut(
        uint priceCumulativeStart, uint priceCumulativeEnd,
        uint timeElapsed, uint amountIn
    ) private pure returns (uint amountOut) {
        // 此处溢出是有意为之的。
        FixedPoint.uq112x112 memory priceAverage = FixedPoint.uq112x112(
            uint224((priceCumulativeEnd - priceCumulativeStart) / timeElapsed)
        );
        amountOut = priceAverage.mul(amountIn).decode144();
    }

    // 对给定 token，基于以下时间范围内的移动平均，返回输入数量（amount in）对应的输出数量（amount out），时间
    // 范围为 [now - [windowSize, windowSize - periodSize * 2], now]
    // 调用前必须已针对时间戳 `now - windowSize` 所对应的 bucket 调用过 update
    function consult(address tokenIn, uint amountIn, address tokenOut) external view returns (uint amountOut) {
        address pair = UniswapV2Library.pairFor(factory, tokenIn, tokenOut);
        Observation storage firstObservation = getFirstObservationInWindow(pair);

        uint timeElapsed = block.timestamp - firstObservation.timestamp;
        require(timeElapsed <= windowSize, 'SlidingWindowOracle: MISSING_HISTORICAL_OBSERVATION');
        // 理论上永远不会发生。
        require(timeElapsed >= windowSize - periodSize * 2, 'SlidingWindowOracle: UNEXPECTED_TIME_ELAPSED');

        (uint price0Cumulative, uint price1Cumulative,) = UniswapV2OracleLibrary.currentCumulativePrices(pair);
        (address token0,) = UniswapV2Library.sortTokens(tokenIn, tokenOut);

        if (token0 == tokenIn) {
            return computeAmountOut(firstObservation.price0Cumulative, price0Cumulative, timeElapsed, amountIn);
        } else {
            return computeAmountOut(firstObservation.price1Cumulative, price1Cumulative, timeElapsed, amountIn);
        }
    }
}
