// #import "cs-template.typ": *
#import "mes-proposal-template.typ": *
#import "@preview/codelst:2.0.0": sourcecode
#show: setup-lovelace

#let algorithm = algorithm.with(supplement: "算法")

#show: project.with(
  anonymous: false,
  title: "基于 ChatGPT 的狗屁通文章生成器但是把标题加长到两行",
  author: "作者",
  school: "复制粘贴写报告学院",
  id: "U000114514",
  mentor: "你的老板",
  class: "XXXX 专业 0000 班",
  date: (1926, 8, 17)
)

= 模板使用注意

本模板参考自 2024 年机械学院本科生毕设开题报告模板，基本使用方法与本科生毕设模板相同，主要使用注意如下：

- 开题报告评审表与开题报告填写要求均为作者在官方模板的基础上手动排版，不能保证一定满足要求，如有必要可手动修改对应的函数
  - 开题报告评审表 `mes_proposal_inspect`
  - 开题报告填写要求 `mes_proposal_declaration`
- 课题研究进度安排表可参考#ref(<tbl:arrange>) 
  - 使用时仅需在对应的学期下添加具体的 `[周次], [工作内容]`
  - 需要根据 `[周次], [工作内容]` 的数量修改 `table.cell` 中的 `rowspan` 参数
  - 该表格已支持跨页功能
  - 后续修改可考虑将该表格封装为一个函数
- 如果希望向开题报告评审表内填入内容，可手动修改函数 `mes_proposal_inspect`

= 国内外研究现状
== XXXX

#lorem(30)#cite(<刘星2014恶意代码的函数调用图相似性分析>)

== YYYY

#lorem(10)#cite(<papadimitriou1998combinatorial>)


= 课题研究进度安排

#[
#set par(leading: 0.75em)
#show figure: set block(breakable: true)
#figure(
  table(
    columns: 3,
    align: left + horizon,
    stroke: (x: none),
    //content
    table.header[学期][周次][工作任务],
    //
    table.cell(rowspan: 2, [2024-2025学年度第一学期]), 
    [××周——××周], [×××××××××××××××××××],
    [××周——××周], [×××××××××××××××××××],
    //
    table.cell(rowspan: 2, [2024-2025学年度第二学期]), 
    [××周——××周], [×××××××××××××××××××],
    [××周——××周], [×××××××××××××××××××],
  ), caption: [课题研究进度安排表], kind: table
) <arrange>
]

#pagebreak()

#bibliography("./ref.bib")
