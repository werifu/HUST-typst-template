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
#import "pages/paper-cover.typ": paper_cover
#import "pages/paper-pages.typ": *

#import "utilities/three-line-table.typ": three_line_table
#import "utilities/indent-funs.typ": *
#import "utilities/bib-cite.typ": *
#import "utilities/set-heading.typ": _set_heading
#import "utilities/set-figure.typ": _set_figure
#import "utilities/set-numbering.typ": _set_numbering

#import "variable/mes-proposal-variable.typ": *

#let project(
  anonymous: false, // 是否匿名化处理
  title: "",
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
  show: _mse_proposal_set_heading
  // 图表公式的排版
  show: _set_figure
  // 图表公式的序号
  show: _set_numbering
  // 参考文献
  show: _mes_proposal_set_references.with(csl_style: "../pages/hust-cse-ug.csl")
  // 修复缩进
  show: _fix_indent
  // 整体页面设置
  show: _set_paper_page_size
  // 修复中文粗体不能正确显示的问题
  show: show-cn-fakebold

  /* 封面与原创性声明 */

  // 封面
  mes_proposal_paper_cover(cover_logo_path: "../assets/cs-hust.png", 
    anonymous, title, school, class, author, id, mentor, date
  )

  // 开题报告填写要求
  mes_proposal_declaration()

  // 正文
  pagebreak()
  counter(page).update(1)

  /* 正文 */

  // 整体页眉
  show: _mes_proposal_set_paper_page_header.with(anonymous: anonymous)
  // 整体段落与页面设置
  show: _set_paper_page_par

  // 正文的页脚
  show: _mes_proposal_set_paper_page_footer_main

  counter(page).update(1)

  body

  pagebreak()

  mes_proposal_inspect()

}
