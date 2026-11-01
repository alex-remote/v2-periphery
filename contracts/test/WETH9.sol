// 版权所有 (C) 2015, 2016, 2017 Dapphub

// 本程序是自由软件：您可以重新分发和/或修改它，
// 但须遵守 GNU 通用公共许可证的条款，该许可证由
// 自由软件基金会发布，可以是许可证的第 3 版，或者
// （由您选择）任何更高的版本。

// 分发本程序是希望它能有用，
// 但不提供任何担保；甚至不提供对
// 适销性或特定用途适用性的默示担保。详情请参阅
// GNU 通用公共许可证。

// 您应当已随本程序一起收到一份 GNU 通用公共许可证的
// 副本。如果没有，请参阅 <http://www.gnu.org/licenses/>。

pragma solidity =0.6.6;

contract WETH9 {
    string public name     = "Wrapped Ether";
    string public symbol   = "WETH";
    uint8  public decimals = 18;

    event  Approval(address indexed src, address indexed guy, uint wad);
    event  Transfer(address indexed src, address indexed dst, uint wad);
    event  Deposit(address indexed dst, uint wad);
    event  Withdrawal(address indexed src, uint wad);

    mapping (address => uint)                       public  balanceOf;
    mapping (address => mapping (address => uint))  public  allowance;

    // function() public payable {
    //     deposit();
    // }
    function deposit() public payable {
        balanceOf[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }
    function withdraw(uint wad) public {
        require(balanceOf[msg.sender] >= wad, "");
        balanceOf[msg.sender] -= wad;
        msg.sender.transfer(wad);
        emit Withdrawal(msg.sender, wad);
    }

    function totalSupply() public view returns (uint) {
        return address(this).balance;
    }

    function approve(address guy, uint wad) public returns (bool) {
        allowance[msg.sender][guy] = wad;
        emit Approval(msg.sender, guy, wad);
        return true;
    }

    function transfer(address dst, uint wad) public returns (bool) {
        return transferFrom(msg.sender, dst, wad);
    }

    function transferFrom(address src, address dst, uint wad)
        public
        returns (bool)
    {
        require(balanceOf[src] >= wad, "");

        if (src != msg.sender && allowance[src][msg.sender] != uint(-1)) {
            require(allowance[src][msg.sender] >= wad, "");
            allowance[src][msg.sender] -= wad;
        }

        balanceOf[src] -= wad;
        balanceOf[dst] += wad;

        emit Transfer(src, dst, wad);

        return true;
    }
}


/*
                    GNU 通用公共许可证
                       第 3 版，2007 年 6 月 29 日

 版权所有 (C) 2007 自由软件基金会 <http://fsf.org/>
 任何人都可以复制和分发本许可证文档的
 逐字副本，但不允许对其进行修改。

                            序言

  GNU 通用公共许可证是一份适用于软件和其他类型作品的
自由的、copyleft 的许可证。

  大多数软件和其他实用作品的许可证，其设计目的
是剥夺您分享和修改这些作品的自由。与之相反，
GNU 通用公共许可证旨在保障您分享和修改
一个程序所有版本的自由——确保它对所有用户而言
始终是自由软件。我们，自由软件基金会，将
GNU 通用公共许可证用于我们的大部分软件；它也适用于
作者以这种方式发布的任何其他作品。您也可以将它
应用于您的程序。

  当我们谈论自由软件时，我们指的是自由，而不是
价格。我们的通用公共许可证旨在确保您
拥有分发自由软件副本的自由（如果您愿意，还可以为此
收费），确保您能收到源代码，或者在您需要时
能够获得源代码，确保您可以修改软件或将其部分用于新的
自由程序中，并确保您知道自己可以做这些事情。

  为了保护您的权利，我们需要防止他人剥夺您的
这些权利，或要求您放弃这些权利。因此，如果您
分发该软件的副本，或者修改该软件，您就负有
一定的责任：尊重他人自由的责任。

  例如，如果您分发此类程序的副本，无论是
免费还是收费，您都必须将您所获得的同等自由
传递给接收者。您必须确保他们同样能收到
或获得源代码。您还必须向他们展示这些条款，使他们
了解自己的权利。

  使用 GNU GPL 的开发者通过两个步骤来保护您的权利：
(1) 主张对软件的版权；(2) 向您提供本许可证，
给予您复制、分发和/或修改该软件的法律许可。

  为了保护开发者和作者，GPL 明确说明
本自由软件不提供任何担保。出于对用户和
作者双方的考虑，GPL 要求修改后的版本必须标明
已被修改，以免其问题被错误地归咎于
先前版本的作者。

  有些设备被设计为拒绝用户安装或运行其内部软件的
修改版本，尽管制造商自己可以这样做。
这与保护用户修改软件之自由的目标
从根本上是不相容的。这种滥用的系统性
模式出现在供个人使用的产品领域，
而这恰恰是最不可接受的领域。因此，我们
设计了此版本的 GPL，以禁止在这些产品上采取这种做法。
如果此类问题在其他领域大量出现，我们
随时准备在未来版本的 GPL 中将此条款扩展到这些领域，
以便在需要时保护用户的自由。

  最后，每个程序都不断受到软件专利的威胁。
国家不应允许专利限制通用计算机上软件的
开发和使用，但在那些允许这样做的国家，我们希望
避免一种特殊的危险：应用于自由程序的专利可能
使其实际上变成专有软件。为了防止这种情况，GPL 确保
专利不能被用来使程序变得不自由。

  以下是有关复制、分发和
修改的确切条款与条件。

                       条款与条件

  0. 定义。

  “本许可证”指 GNU 通用公共许可证第 3 版。

  “版权”也指适用于其他类型作品的类似版权的法律，
例如适用于半导体掩模的法律。

  “本程序”指依据本许可证授权的任何可受版权保护的
作品。每个被许可人都被称为“您”。“被许可人”和
“接收者”可以是个人，也可以是组织。

  “修改”一个作品，是指以需要获得版权许可的方式复制或改编
该作品的全部或部分，但制作完全相同的副本
除外。由此产生的作品被称为先前作品的“修改版本”，
或“基于”先前作品的作品。

  “受保护作品”是指未经修改的本程序，或基于
本程序的作品。

  “传播”一个作品，是指对其进行的任何未经
许可便会使您根据适用的版权法承担直接或间接
侵权责任的行为，但在计算机上执行该作品
或修改私人副本除外。传播包括复制、
分发（无论是否经过修改）、向公众提供，
在某些国家还包括其他活动。

  “传递”一个作品，是指任何使其他方能够制作或接收副本的
传播行为。仅通过计算机网络与用户进行交互，
而没有转移副本，不属于传递。

  交互式用户界面在以下范围内即被视为显示了“适当的法律声明”：
该界面包含一个便利且显著可见的
功能，该功能 (1) 显示适当的版权声明，并且 (2)
告知用户该作品不提供担保（已提供担保的
情况除外）、被许可人可以依据本许可证传递该
作品，以及如何查看本许可证的副本。如果
该界面提供用户命令或选项的列表（例如
菜单），则列表中的一个显著条目即满足此标准。

  1. 源代码。

  作品的“源代码”是指对该作品进行修改时
所首选的作品形式。“目标代码”是指作品的任何非源代码
形式。

  “标准接口”是指这样一种接口：它或者是由公认的
标准机构定义的官方标准，或者在针对
特定编程语言规定的接口的情况下，是在使用
该语言的开发者中被广泛使用的接口。

  可执行作品的“系统库”包括除该作品整体之外，
满足以下条件的任何内容：(a) 包含在打包
某个主要组件的常规形式中，但不属于该主要
组件的一部分；并且 (b) 仅用于使该作品能够与该
主要组件一起使用，或用于实现某个标准接口，且该接口的
实现已以源代码形式向公众提供。在此语境下，
“主要组件”是指该可执行作品所运行的特定操作系统
（如果有的话）的主要基本组件（内核、窗口系统等），
或用于生成该作品的编译器，
或用于运行该作品的目标代码解释器。

  目标代码形式的作品的“对应源代码”是指
生成、安装以及（对于可执行作品）运行该目标代码，
以及修改该作品所需的全部源代码，包括用于
控制这些活动的脚本。但是，它不包括该作品的
系统库，也不包括在执行这些活动时未经修改而使用、
但并非该作品一部分的通用工具或普遍可获得的自由
程序。例如，对应源代码
包括与该作品源文件相关联的接口定义文件，
以及该作品经专门设计而需要的共享库和动态
链接子程序的源代码，例如这些子程序与
该作品其他部分之间存在密切的数据通信或
控制流的情形。

  对应源代码无需包含用户
可以从对应源代码的其他部分自动重新生成的
任何内容。

  源代码形式的作品的对应源代码就是
该作品本身。

  2. 基本许可。

  依据本许可证授予的所有权利，其授予期限为本程序的
版权期限，并且只要满足所述
条件即不可撤销。本许可证明确确认您拥有不受限制地
运行未经修改的本程序的许可。运行
受保护作品所产生的输出，仅当该输出就其
内容而言构成受保护作品时，才受本许可证保护。本许可证承认您
享有版权法所规定的合理使用权或其他同等权利。

  您可以制作、运行和传播您不传递的受保护作品，
只要您的许可在其他方面仍然有效，便无需任何条件。
您可以将受保护作品传递给他人，其唯一目的
是让他们专门为您进行修改，或为您提供
运行这些作品的设施，前提是您在传递所有您
不控制其版权的材料时遵守本许可证的
条款。如此为您制作或运行受保护作品的人，
必须完全代表您、在您的指示
和控制下进行，且所依据的条款须禁止他们在与您的关系之外
制作您享有版权的材料的任何副本。

  在任何其他情况下进行传递，仅在满足
下文所述条件时才被允许。不允许再许可；第 10 节
使再许可变得没有必要。

  3. 保护用户的合法权利免受反规避法的影响。

  任何受保护作品均不得依据以下法律被视为有效技术
措施的一部分：为履行 1996 年 12 月 20 日通过的
WIPO 版权条约第 11 条规定之义务而制定的任何适用法律，或
禁止或限制规避此类
措施的类似法律。

  当您传递受保护作品时，您即放弃禁止
规避技术措施的任何法律权力，只要这种规避
是通过行使本许可证就该受保护作品所授予的权利
而实现的；并且您声明放弃任何以限制该作品的运行或
修改为手段，针对该作品的
用户强制执行您或第三方禁止规避
技术措施之合法权利的意图。

  4. 传递逐字副本。

  您可以通过任何介质，传递您所收到的本程序源代码的
逐字副本，前提是您在每份副本上显著且
适当地发布适当的版权声明；
完整保留所有声明本许可证以及
依据第 7 节添加的任何非许可性条款适用于该代码的声明；
完整保留所有关于不提供任何担保的声明；并随本程序向所有
接收者提供一份本许可证的副本。

  您可以对您传递的每份副本收取任何价格或不收取费用，
并且您可以有偿提供支持或担保保护。

  5. 传递修改后的源代码版本。

  您可以传递基于本程序的作品，或从本程序产生该作品所做的
修改，以源代码形式并依据
第 4 节的条款进行传递，前提是您同时满足以下所有条件：

    a) 该作品必须带有显著的声明，说明您修改了
    它，并注明相关日期。

    b) 该作品必须带有显著的声明，说明它是
    依据本许可证以及依据第
    7 节所添加的任何条件发布的。此要求修改了第 4 节中关于
    “完整保留所有声明”的要求。

    c) 您必须依据本许可证，将整个作品作为一个整体，
    授权给任何获得其副本的人。因此，本
    许可证连同任何适用的第 7 节
    附加条款，将适用于整个作品及其所有部分，
    无论它们以何种方式打包。本许可证不给予
    以任何其他方式授权该作品的许可，但它并不
    使您另行获得的此类许可失效。

    d) 如果该作品具有交互式用户界面，则每个界面都必须显示
    Appropriate Legal Notices; however, if the Program has interactive
    interfaces that do not display Appropriate Legal Notices, your
    work need not make them do so.

  A compilation of a covered work with other separate and independent
works, which are not by their nature extensions of the covered work,
and which are not combined with it such as to form a larger program,
in or on a volume of a storage or distribution medium, is called an
"aggregate" if the compilation and its resulting copyright are not
used to limit the access or legal rights of the compilation's users
beyond what the individual works permit.  Inclusion of a covered work
in an aggregate does not cause this License to apply to the other
parts of the aggregate.

  6. Conveying Non-Source Forms.

  You may convey a covered work in object code form under the terms
of sections 4 and 5, provided that you also convey the
machine-readable Corresponding Source under the terms of this License,
in one of these ways:

    a) Convey the object code in, or embodied in, a physical product
    (including a physical distribution medium), accompanied by the
    Corresponding Source fixed on a durable physical medium
    customarily used for software interchange.

    b) Convey the object code in, or embodied in, a physical product
    (including a physical distribution medium), accompanied by a
    written offer, valid for at least three years and valid for as
    long as you offer spare parts or customer support for that product
    model, to give anyone who possesses the object code either (1) a
    copy of the Corresponding Source for all the software in the
    product that is covered by this License, on a durable physical
    medium customarily used for software interchange, for a price no
    more than your reasonable cost of physically performing this
    conveying of source, or (2) access to copy the
    Corresponding Source from a network server at no charge.

    c) Convey individual copies of the object code with a copy of the
    written offer to provide the Corresponding Source.  This
    alternative is allowed only occasionally and noncommercially, and
    only if you received the object code with such an offer, in accord
    with subsection 6b.

    d) Convey the object code by offering access from a designated
    place (gratis or for a charge), and offer equivalent access to the
    Corresponding Source in the same way through the same place at no
    further charge.  You need not require recipients to copy the
    Corresponding Source along with the object code.  If the place to
    copy the object code is a network server, the Corresponding Source
    may be on a different server (operated by you or a third party)
    that supports equivalent copying facilities, provided you maintain
    clear directions next to the object code saying where to find the
    Corresponding Source.  Regardless of what server hosts the
    Corresponding Source, you remain obligated to ensure that it is
    available for as long as needed to satisfy these requirements.

    e) Convey the object code using peer-to-peer transmission, provided
    you inform other peers where the object code and Corresponding
    Source of the work are being offered to the general public at no
    charge under subsection 6d.

  A separable portion of the object code, whose source code is excluded
from the Corresponding Source as a System Library, need not be
included in conveying the object code work.

  A "User Product" is either (1) a "consumer product", which means any
tangible personal property which is normally used for personal, family,
or household purposes, or (2) anything designed or sold for incorporation
into a dwelling.  In determining whether a product is a consumer product,
doubtful cases shall be resolved in favor of coverage.  For a particular
product received by a particular user, "normally used" refers to a
typical or common use of that class of product, regardless of the status
of the particular user or of the way in which the particular user
actually uses, or expects or is expected to use, the product.  A product
is a consumer product regardless of whether the product has substantial
commercial, industrial or non-consumer uses, unless such uses represent
the only significant mode of use of the product.

  "Installation Information" for a User Product means any methods,
procedures, authorization keys, or other information required to install
and execute modified versions of a covered work in that User Product from
a modified version of its Corresponding Source.  The information must
suffice to ensure that the continued functioning of the modified object
code is in no case prevented or interfered with solely because
modification has been made.

  If you convey an object code work under this section in, or with, or
specifically for use in, a User Product, and the conveying occurs as
part of a transaction in which the right of possession and use of the
User Product is transferred to the recipient in perpetuity or for a
fixed term (regardless of how the transaction is characterized), the
Corresponding Source conveyed under this section must be accompanied
by the Installation Information.  But this requirement does not apply
if neither you nor any third party retains the ability to install
modified object code on the User Product (for example, the work has
been installed in ROM).

  The requirement to provide Installation Information does not include a
requirement to continue to provide support service, warranty, or updates
for a work that has been modified or installed by the recipient, or for
the User Product in which it has been modified or installed.  Access to a
network may be denied when the modification itself materially and
adversely affects the operation of the network or violates the rules and
protocols for communication across the network.

  Corresponding Source conveyed, and Installation Information provided,
in accord with this section must be in a format that is publicly
documented (and with an implementation available to the public in
source code form), and must require no special password or key for
unpacking, reading or copying.

  7. Additional Terms.

  "Additional permissions" are terms that supplement the terms of this
License by making exceptions from one or more of its conditions.
Additional permissions that are applicable to the entire Program shall
be treated as though they were included in this License, to the extent
that they are valid under applicable law.  If additional permissions
apply only to part of the Program, that part may be used separately
under those permissions, but the entire Program remains governed by
this License without regard to the additional permissions.

  When you convey a copy of a covered work, you may at your option
remove any additional permissions from that copy, or from any part of
it.  (Additional permissions may be written to require their own
removal in certain cases when you modify the work.)  You may place
additional permissions on material, added by you to a covered work,
for which you have or can give appropriate copyright permission.

  Notwithstanding any other provision of this License, for material you
add to a covered work, you may (if authorized by the copyright holders of
that material) supplement the terms of this License with terms:

    a) Disclaiming warranty or limiting liability differently from the
    terms of sections 15 and 16 of this License; or

    b) Requiring preservation of specified reasonable legal notices or
    author attributions in that material or in the Appropriate Legal
    Notices displayed by works containing it; or

    c) Prohibiting misrepresentation of the origin of that material, or
    requiring that modified versions of such material be marked in
    reasonable ways as different from the original version; or

    d) Limiting the use for publicity purposes of names of licensors or
    authors of the material; or

    e) Declining to grant rights under trademark law for use of some
    trade names, trademarks, or service marks; or

    f) Requiring indemnification of licensors and authors of that
    material by anyone who conveys the material (or modified versions of
    it) with contractual assumptions of liability to the recipient, for
    any liability that these contractual assumptions directly impose on
    those licensors and authors.

  All other non-permissive additional terms are considered "further
restrictions" within the meaning of section 10.  If the Program as you
received it, or any part of it, contains a notice stating that it is
governed by this License along with a term that is a further
restriction, you may remove that term.  If a license document contains
a further restriction but permits relicensing or conveying under this
License, you may add to a covered work material governed by the terms
of that license document, provided that the further restriction does
not survive such relicensing or conveying.

  If you add terms to a covered work in accord with this section, you
must place, in the relevant source files, a statement of the
additional terms that apply to those files, or a notice indicating
where to find the applicable terms.

  Additional terms, permissive or non-permissive, may be stated in the
form of a separately written license, or stated as exceptions;
the above requirements apply either way.

  8. Termination.

  You may not propagate or modify a covered work except as expressly
provided under this License.  Any attempt otherwise to propagate or
modify it is void, and will automatically terminate your rights under
this License (including any patent licenses granted under the third
paragraph of section 11).

  However, if you cease all violation of this License, then your
license from a particular copyright holder is reinstated (a)
provisionally, unless and until the copyright holder explicitly and
finally terminates your license, and (b) permanently, if the copyright
holder fails to notify you of the violation by some reasonable means
prior to 60 days after the cessation.

  Moreover, your license from a particular copyright holder is
reinstated permanently if the copyright holder notifies you of the
violation by some reasonable means, this is the first time you have
received notice of violation of this License (for any work) from that
copyright holder, and you cure the violation prior to 30 days after
your receipt of the notice.

  Termination of your rights under this section does not terminate the
licenses of parties who have received copies or rights from you under
this License.  If your rights have been terminated and not permanently
reinstated, you do not qualify to receive new licenses for the same
material under section 10.

  9. Acceptance Not Required for Having Copies.

  You are not required to accept this License in order to receive or
run a copy of the Program.  Ancillary propagation of a covered work
occurring solely as a consequence of using peer-to-peer transmission
to receive a copy likewise does not require acceptance.  However,
nothing other than this License grants you permission to propagate or
modify any covered work.  These actions infringe copyright if you do
not accept this License.  Therefore, by modifying or propagating a
covered work, you indicate your acceptance of this License to do so.

  10. Automatic Licensing of Downstream Recipients.

  Each time you convey a covered work, the recipient automatically
receives a license from the original licensors, to run, modify and
propagate that work, subject to this License.  You are not responsible
for enforcing compliance by third parties with this License.

  An "entity transaction" is a transaction transferring control of an
organization, or substantially all assets of one, or subdividing an
organization, or merging organizations.  If propagation of a covered
work results from an entity transaction, each party to that
transaction who receives a copy of the work also receives whatever
licenses to the work the party's predecessor in interest had or could
give under the previous paragraph, plus a right to possession of the
Corresponding Source of the work from the predecessor in interest, if
the predecessor has it or can get it with reasonable efforts.

  You may not impose any further restrictions on the exercise of the
rights granted or affirmed under this License.  For example, you may
not impose a license fee, royalty, or other charge for exercise of
rights granted under this License, and you may not initiate litigation
(including a cross-claim or counterclaim in a lawsuit) alleging that
any patent claim is infringed by making, using, selling, offering for
sale, or importing the Program or any portion of it.

  11. Patents.

  A "contributor" is a copyright holder who authorizes use under this
License of the Program or a work on which the Program is based.  The
work thus licensed is called the contributor's "contributor version".

  A contributor's "essential patent claims" are all patent claims
owned or controlled by the contributor, whether already acquired or
hereafter acquired, that would be infringed by some manner, permitted
by this License, of making, using, or selling its contributor version,
but do not include claims that would be infringed only as a
consequence of further modification of the contributor version.  For
purposes of this definition, "control" includes the right to grant
patent sublicenses in a manner consistent with the requirements of
this License.

  Each contributor grants you a non-exclusive, worldwide, royalty-free
patent license under the contributor's essential patent claims, to
make, use, sell, offer for sale, import and otherwise run, modify and
propagate the contents of its contributor version.

  In the following three paragraphs, a "patent license" is any express
agreement or commitment, however denominated, not to enforce a patent
(such as an express permission to practice a patent or covenant not to
sue for patent infringement).  To "grant" such a patent license to a
party means to make such an agreement or commitment not to enforce a
patent against the party.

  If you convey a covered work, knowingly relying on a patent license,
and the Corresponding Source of the work is not available for anyone
to copy, free of charge and under the terms of this License, through a
publicly available network server or other readily accessible means,
then you must either (1) cause the Corresponding Source to be so
available, or (2) arrange to deprive yourself of the benefit of the
patent license for this particular work, or (3) arrange, in a manner
consistent with the requirements of this License, to extend the patent
license to downstream recipients.  "Knowingly relying" means you have
actual knowledge that, but for the patent license, your conveying the
covered work in a country, or your recipient's use of the covered work
in a country, would infringe one or more identifiable patents in that
country that you have reason to believe are valid.

  If, pursuant to or in connection with a single transaction or
arrangement, you convey, or propagate by procuring conveyance of, a
covered work, and grant a patent license to some of the parties
receiving the covered work authorizing them to use, propagate, modify
or convey a specific copy of the covered work, then the patent license
you grant is automatically extended to all recipients of the covered
work and works based on it.

  A patent license is "discriminatory" if it does not include within
the scope of its coverage, prohibits the exercise of, or is
conditioned on the non-exercise of one or more of the rights that are
specifically granted under this License.  You may not convey a covered
work if you are a party to an arrangement with a third party that is
in the business of distributing software, under which you make payment
to the third party based on the extent of your activity of conveying
the work, and under which the third party grants, to any of the
parties who would receive the covered work from you, a discriminatory
patent license (a) in connection with copies of the covered work
conveyed by you (or copies made from those copies), or (b) primarily
for and in connection with specific products or compilations that
contain the covered work, unless you entered into that arrangement,
or that patent license was granted, prior to 28 March 2007.

  Nothing in this License shall be construed as excluding or limiting
any implied license or other defenses to infringement that may
otherwise be available to you under applicable patent law.

  12. No Surrender of Others' Freedom.

  If conditions are imposed on you (whether by court order, agreement or
otherwise) that contradict the conditions of this License, they do not
excuse you from the conditions of this License.  If you cannot convey a
covered work so as to satisfy simultaneously your obligations under this
License and any other pertinent obligations, then as a consequence you may
not convey it at all.  For example, if you agree to terms that obligate you
to collect a royalty for further conveying from those to whom you convey
the Program, the only way you could satisfy both those terms and this
License would be to refrain entirely from conveying the Program.

  13. Use with the GNU Affero General Public License.

  Notwithstanding any other provision of this License, you have
permission to link or combine any covered work with a work licensed
under version 3 of the GNU Affero General Public License into a single
combined work, and to convey the resulting work.  The terms of this
License will continue to apply to the part which is the covered work,
but the special requirements of the GNU Affero General Public License,
section 13, concerning interaction through a network will apply to the
combination as such.

  14. Revised Versions of this License.

  The Free Software Foundation may publish revised and/or new versions of
the GNU General Public License from time to time.  Such new versions will
be similar in spirit to the present version, but may differ in detail to
address new problems or concerns.

  Each version is given a distinguishing version number.  If the
Program specifies that a certain numbered version of the GNU General
Public License "or any later version" applies to it, you have the
option of following the terms and conditions either of that numbered
version or of any later version published by the Free Software
Foundation.  If the Program does not specify a version number of the
GNU General Public License, you may choose any version ever published
by the Free Software Foundation.

  If the Program specifies that a proxy can decide which future
versions of the GNU General Public License can be used, that proxy's
public statement of acceptance of a version permanently authorizes you
to choose that version for the Program.

  Later license versions may give you additional or different
permissions.  However, no additional obligations are imposed on any
author or copyright holder as a result of your choosing to follow a
later version.

  15. Disclaimer of Warranty.

  THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY
APPLICABLE LAW.  EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT
HOLDERS AND/OR OTHER PARTIES PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY
OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE.  THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM
IS WITH YOU.  SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF
ALL NECESSARY SERVICING, REPAIR OR CORRECTION.

  16. Limitation of Liability.

  IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MODIFIES AND/OR CONVEYS
THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY
GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE
USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED TO LOSS OF
DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD
PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER PROGRAMS),
EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.

  17. Interpretation of Sections 15 and 16.

  If the disclaimer of warranty and limitation of liability provided
above cannot be given local legal effect according to their terms,
reviewing courts shall apply local law that most closely approximates
an absolute waiver of all civil liability in connection with the
Program, unless a warranty or assumption of liability accompanies a
copy of the Program in return for a fee.

                     END OF TERMS AND CONDITIONS

            How to Apply These Terms to Your New Programs

  If you develop a new program, and you want it to be of the greatest
possible use to the public, the best way to achieve this is to make it
free software which everyone can redistribute and change under these terms.

  To do so, attach the following notices to the program.  It is safest
to attach them to the start of each source file to most effectively
state the exclusion of warranty; and each file should have at least
the "copyright" line and a pointer to where the full notice is found.

    <one line to give the program's name and a brief idea of what it does.>
    Copyright (C) <year>  <name of author>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

Also add information on how to contact you by electronic and paper mail.

  If the program does terminal interaction, make it output a short
notice like this when it starts in an interactive mode:

    <program>  Copyright (C) <year>  <name of author>
    This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
    This is free software, and you are welcome to redistribute it
    under certain conditions; type `show c' for details.

The hypothetical commands `show w' and `show c' should show the appropriate
parts of the General Public License.  Of course, your program's commands
might be different; for a GUI interface, you would use an "about box".

  You should also get your employer (if you work as a programmer) or school,
if any, to sign a "copyright disclaimer" for the program, if necessary.
For more information on this, and how to apply and follow the GNU GPL, see
<http://www.gnu.org/licenses/>.

  The GNU General Public License does not permit incorporating your program
into proprietary programs.  If your program is a subroutine library, you
may consider it more useful to permit linking proprietary applications with
the library.  If this is what you want to do, use the GNU Lesser General
Public License instead of this License.  But first, please read
<http://www.gnu.org/philosophy/why-not-lgpl.html>.

*/