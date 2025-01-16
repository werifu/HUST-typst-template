#import "@preview/lovelace:0.2.0": *
// 使用伪粗体修复中文粗体不能正确显示的问题
#import "@preview/cuti:0.3.0": show-cn-fakebold

#import "fonts/font-def.typ": *
#import "pages/acknowledgement.typ": acknowledgement
#import "pages/chinese-outline.typ": chinese_outline
#import "pages/declaration.typ": declaration
#import "pages/zh-abstract-page.typ": zh_abstract_page
#import "pages/en-abstract-page.typ": en_abstract_page
#import "pages/references.typ": _set_references
// #import "pages/paper-cover.typ": paper_cover
#import "pages/paper-pages.typ": *

#import "utilities/three-line-table.typ": three_line_table
#import "utilities/indent-funs.typ": *
#import "utilities/bib-cite.typ": *
#import "utilities/set-heading.typ": _set_heading
#import "utilities/set-figure.typ": _set_figure
#import "utilities/set-numbering.typ": _set_numbering

#import "variable/mes-trans-variable.typ": *

#let project(
  anonymous: false, // 是否匿名化处理
  title: "",
  title_trans: "",
  abstract_zh: [],
  keywords_zh: (),
  school: "",
  author: "",
  id: "",
  mentor: "",
  class: "",
  date: (1926, 8, 17),
  body,
) = {
  /* 全局整体设置 */

  // 设置标题, 需要在图表前设置
  show: _mse_trans_set_heading
  // 图表公式的排版
  show: _mes_trans_set_figure
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

  /* 封面与原创性声明 */

  // 封面
  mes_trans_paper_cover(cover_logo_path: "../assets/cs-hust.png", 
    anonymous, title, school, class, author, id, mentor, date
  )

  // 翻译封底
  mes_trans_declaration()

  // 进入下一部分
  pagebreak()
  counter(page).update(1)

  /* 目录与摘要 */

  // 整体页眉
  show: _mes_trans_set_paper_page_header.with(anonymous: anonymous)
  // 目录与摘要的页脚
  show: _set_paper_page_footer_pre
  // 整体段落与页面设置
  show: _mes_trans_set_paper_page_par

  /* 正文 */

  // 正文的页脚
  show: _set_paper_page_footer_main

  counter(page).update(1)

  align(center)[
  #text(size: 14pt, weight: "bold")[#title_trans]
  ]

  // 摘要
  mes_trans_abstract(abstract_zh, keywords: keywords_zh)

  body

  orgin_intro()
}
