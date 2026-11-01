# 英文注释中文翻译 · 任务进度跟踪

> 分支：`v2-periphery_zh`　｜　统计日期：2026-11-01

## 翻译规则

1. 在英文原文的位置直接替换为中文，翻译后**行数不变**（逐行对应，不增删行，末尾换行状态保持原样）。
2. 保留专有名词、函数名、变量名、合约名、代码片段等代码内的明确指代（如 `getAmountsOut`、`WETH`、`reserve0`、`TWAP`、`UQ112x112`）。
3. 只翻译注释；字符串字面量、`revert` 信息、测试用例名称、YAML 配置值等代码/数据内容不改动。
4. 英文 `.md` 文件另存为同路径下的 `*_zh.md`，原件保留不动，译文行数与原件一致。

## 统计概览

| 项目 | 数量 |
| --- | --- |
| 仓库跟踪文件总数 | 49 个（合计 13014 行） |
| 需翻译：含英文注释的源码 / 配置文件 | 25 个 |
| 需翻译：英文 `.md` 文件（生成 `_zh.md`） | 2 个 |
| **需翻译文件合计** | **27 个**（其中 `WETH9.sol` 拆为 3 段并行，共 29 个任务项） |
| 无需翻译（无注释 / 数据文件 / 许可证正文） | 22 个 |

## 翻译任务清单

> 勾选 = 已翻译并通过行数校验。“子代理”列为分派编号。

| 状态 | 文件 | 行数 | 子代理 | 翻译后行数 |
| --- | --- | ---: | --- | ---: |
| [x] | `contracts/UniswapV2Router01.sol` | 280 | #01 | 280 |
| [x] | `contracts/UniswapV2Migrator.sol` | 49 | #01 | 49 |
| [x] | `contracts/UniswapV2Router02.sol` | 446 | #02 | 446 |
| [x] | `contracts/examples/ExampleFlashSwap.sol` | 67 | #03 | 67 |
| [x] | `contracts/examples/ExampleComputeLiquidityValue.sol` | 90 | #03 | 90 |
| [x] | `contracts/examples/ExampleSlidingWindowOracle.sol` | 125 | #04 | 125 |
| [x] | `contracts/examples/ExampleOracleSimple.sol` | 67 | #05 | 67 |
| [x] | `contracts/examples/ExampleSwapToPrice.sol` | 77 | #05 | 77 |
| [x] | `contracts/libraries/UniswapV2LiquidityMathLibrary.sol` | 139 | #06 | 139 |
| [x] | `contracts/libraries/SafeMath.sol` | 17 | #06 | 17 |
| [x] | `contracts/libraries/UniswapV2Library.sol` | 82 | #07 | 82 |
| [x] | `contracts/libraries/UniswapV2OracleLibrary.sol` | 35 | #07 | 35 |
| [x] | `contracts/test/DeflatingERC20.sol` | 97 | #08 | 97 |
| [x] | `contracts/test/ERC20.sol` | 94 | #08 | 94 |
| [x] | `.github/stale.yml` | 25 | #08 | 25 |
| [x] | `.github/workflows/CI.yml` | 38 | #08 | 38 |
| [x] | `contracts/test/WETH9.sol`（第 1–310 行） | 756 | #09 | 756 |
| [ ] | `contracts/test/WETH9.sol`（第 311–540 行） | 〃 | #10 | |
| [x] | `contracts/test/WETH9.sol`（第 541–756 行） | 〃 | #11 | 756 |
| [x] | `test/ExampleComputeLiquidityValue.spec.ts` | 454 | #12 | 454 |
| [x] | `test/ExampleSwapToPrice.spec.ts` | 198 | #12 | 198 |
| [x] | `test/ExampleFlashSwap.spec.ts` | 153 | #13 | 153 |
| [x] | `test/UniswapV2Migrator.spec.ts` | 70 | #13 | 70 |
| [x] | `test/ExampleSlidingWindowOracle.spec.ts` | 294 | #14 | 294 |
| [x] | `test/UniswapV2Router01.spec.ts` | 734 | #15 | 734 |
| [x] | `test/UniswapV2Router02.spec.ts` | 380 | #15 | 380 |
| [x] | `test/shared/fixtures.ts` | 100 | #15 | 100 |
| [x] | `README.md` → `README_zh.md` | 24 | #16 | 24 |
| [x] | `contracts/examples/README.md` → `contracts/examples/README_zh.md` | 14 | #16 | 14 |

## 无需翻译的文件

| 文件 | 行数 | 原因 |
| --- | ---: | --- |
| `contracts/interfaces/IERC20.sol` | 17 | 无注释 |
| `contracts/interfaces/IUniswapV2Migrator.sol` | 5 | 无注释 |
| `contracts/interfaces/IUniswapV2Router01.sol` | 95 | 无注释 |
| `contracts/interfaces/IUniswapV2Router02.sol` | 44 | 无注释 |
| `contracts/interfaces/IWETH.sol` | 7 | 无注释 |
| `contracts/interfaces/V1/IUniswapV1Exchange.sol` | 9 | 无注释 |
| `contracts/interfaces/V1/IUniswapV1Factory.sol` | 5 | 无注释 |
| `contracts/test/RouterEventEmitter.sol` | 97 | 无注释 |
| `test/ExampleOracleSimple.spec.ts` | 70 | 无注释 |
| `test/shared/utilities.ts` | 77 | 无注释 |
| `package.json` | 48 | JSON 配置，无注释 |
| `tsconfig.json` | 9 | JSON 配置，无注释 |
| `.mocharc.json` | 6 | JSON 配置，无注释 |
| `.waffle.json` | 24 | JSON 配置，无注释 |
| `.prettierrc` | 5 | 配置，无注释 |
| `.yarnrc` | 1 | 配置，无注释 |
| `.gitignore` | 2 | 配置，无注释 |
| `.gitattributes` | 1 | 配置，无注释 |
| `LICENSE` | 674 | 许可证正文（非注释，保持原件） |
| `buildV1/UniswapV1Exchange.json` | 485 | 编译产物（数据） |
| `buildV1/UniswapV1Factory.json` | 81 | 编译产物（数据） |
| `yarn.lock` | 6347 | 依赖锁文件（数据） |

## 进度日志

- 2026-11-01：完成文件统计，创建本跟踪文档；分派 16 个子代理并行翻译。
- 子代理 #12 完成：test/ExampleComputeLiquidityValue.spec.ts=454，test/ExampleSwapToPrice.spec.ts=198
- 子代理 #16 完成：README_zh.md=24，contracts/examples/README_zh.md=14；原 README.md 未改动
- 子代理 #02 完成：contracts/UniswapV2Router02.sol=446
- 子代理 #15 完成：test/UniswapV2Router01.spec.ts=734，test/UniswapV2Router02.spec.ts=380，test/shared/fixtures.ts=100
- 子代理 #08 完成：contracts/test/DeflatingERC20.sol=97，contracts/test/ERC20.sol=94，.github/stale.yml=25，.github/workflows/CI.yml=38；ERC20/DeflatingERC20 仅含 keccak256 代码片段注释、CI.yml 仅含 `# v1` 版本标注，均保持原样；stale.yml 译 7 行
- 子代理 #01 完成：contracts/UniswapV2Router01.sol=280，contracts/UniswapV2Migrator.sol=49
- 子代理 #03 完成：contracts/examples/ExampleFlashSwap.sol=67，contracts/examples/ExampleComputeLiquidityValue.sol=90
- 子代理 #07 完成：contracts/libraries/UniswapV2Library.sol=82，contracts/libraries/UniswapV2OracleLibrary.sol=35
- 子代理 #05 完成：contracts/examples/ExampleOracleSimple.sol=67，contracts/examples/ExampleSwapToPrice.sol=77
- 子代理 #13 完成：test/ExampleFlashSwap.spec.ts=153，test/UniswapV2Migrator.spec.ts=70
- 子代理 #14 完成：test/ExampleSlidingWindowOracle.spec.ts=294
- 子代理 #04 完成：contracts/examples/ExampleSlidingWindowOracle.sol=125
- 子代理 #06 完成：contracts/libraries/UniswapV2LiquidityMathLibrary.sol=139，contracts/libraries/SafeMath.sol=17
- 子代理 #09 完成：contracts/test/WETH9.sol=756；第 1–14 行版权声明与第 81–310 行 GPL 正文已译，第 15–79 行合约代码与 HEAD 一致
- 子代理 #11 完成：contracts/test/WETH9.sol=756；第 541–755 行 GPL 正文已译，第 756 行 `*/` 保持，末尾无换行
