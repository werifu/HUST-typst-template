#import "@preview/lovelace:0.2.0": *
// 使用伪粗体修复中文粗体不能正确显示的问题
#import "@preview/cuti:0.3.0": show-cn-fakebold

#import "fonts/font-def.typ": *
#import "pages/acknowledgement.typ": acknowledgement
#import "pages/chinese-outline.typ": chinese_outline
#import "pages/declaration.typ": declaration
#import "pages/zh-abstract-page.typ": zh_abstract_page
#import "pages/references.typ": _set_references
#import "pages/paper-pages.typ": *

#import "utilities/three-line-table.typ": three_line_table
#import "utilities/indent-funs.typ": *
#import "utilities/bib-cite.typ": *
#import "utilities/set-heading.typ": _set_heading
#import "utilities/set-figure.typ": _set_figure
#import "utilities/set-numbering.typ": _set_numbering

#import "variable/master-exam-variable.typ": *

#let project(
  anonymous: false, // 是否匿名化处理
  author: "",
  grade: "",
  kind: "",
  id: "",
  course: "",
  date: (1926, 8, 17),
  body,
  abstract: "",
  keywords: (),
) = {

  /* 全局整体设置 */

  // 设置标题, 需要在图表前设置
  show: _set_heading
  // 图表公式的排版
  show: _set_figure
  // 图表公式的序号
  show: _set_numbering
  // 参考文献
  show: _set_references.with(csl_style: "hust-cse-ug.csl")
  // 修复缩进
  show: _fix_indent
  // 整体页面设置
  show: _set_paper_page_size
  // 修复中文粗体不能正确显示的问题
  show: show-cn-fakebold

  // 封面
  //   #set text(
  //     font: songti,
  //     size: 16pt,
  //   )
  //   #v(100pt)

  //   #text(font: songti, size: 26pt)[
  //     #align(center)[
  //       华 中 科 技 大 学

  //       研究生课程考试答题本
  //     ]
  //   ]

  //   #v(220pt)

  //   #align(center)[

  //     #let info_value(body) = {
  //       rect(
  //         width: 100%,
  //         inset: 2pt,
  //         stroke: (
  //           bottom: 1pt + black,
  //         ),
  //         text(
  //           font: songti,
  //           size: 16pt,
  //           bottom-edge: "descender",
  //         )[
  //           #body
  //         ],
  //       )
  //     }

  //     #let info_key(body) = {
  //       rect(
  //         width: 100%,
  //         inset: 2pt,
  //         stroke: none,
  //         text(
  //           font: songti,
  //           size: 16pt,
  //           bottom-edge: "descender",
  //         )[
  //           #body
  //         ],
  //       )
  //     }

  //     #block(width: 18em)[
  //       #grid(
  //         columns: (4.3em, 1fr),
  //         rows: (1.8em),
  //         gutter: 3pt,
  //         info_key("考生姓名"), info_value([#author]),
  //         info_key("考生学号"), info_value([#id]),
  //         info_key("系、年级"), info_value([#grade]),
  //         info_key("类        别"), info_value([#kind]),
  //         info_key("考试科目"), info_value([#course]),
  //         info_key("考试日期"), info_value([#date.at(0) 年 #date.at(1) 月 #date.at(2) 日]),
  //       )]]

  //   #pagebreak()
  // ]
  master_exam_cover(
    author: author,
    id: id,
    grade: grade,
    kind: kind,
    course: course,
    date: date,
  )

  // 评分页
  master_exam_score()

  counter(page).update(0)
  // 页眉
  show: _master_exam_set_paper_page_header.with(anonymous: anonymous)

// 目录与摘要的页脚
  show: _set_paper_page_footer_pre
  // 整体段落与页面设置
  show: _set_paper_page_par

  // 原创性声明与摘要间的空页
  pagebreak()
  counter(page).update(1)

  // 摘要
  zh_abstract_page(abstract, keywords: keywords)

  pagebreak()

  // 目录
  chinese_outline()

  /* 正文 */

  // 正文的页脚
  show: _set_paper_page_footer_main

  counter(page).update(1)

  body
}
