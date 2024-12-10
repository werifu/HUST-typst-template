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
#import "pages/paper-pages.typ": *

#import "utilities/three-line-table.typ": three_line_table
#import "utilities/indent-funs.typ": *
#import "utilities/bib-cite.typ": *
#import "utilities/set-heading.typ": _set_heading
#import "utilities/set-figure.typ": _set_figure
#import "utilities/set-numbering.typ": _set_numbering

#import "variable/postgraduate-report-variable.typ": *

#let project(
  subject: [],
  title: [],
  author: [],
  major: [],
  id: [],
  suporvisor: [],
  college: [],
  date: datetime.today(),
  body,
  abstract: [],
  abstract_en: [],
  keywords: (),
  keywords_en: (),
  asymmetric_margin: false,
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

  postgraduate-report-cover(
    title: title,
    subject: subject,
    author: author,
    student-id: id,
    major: major,
    suporvisor: suporvisor,
    college: college,
  )

  // 评分页
  // postgraduate_exam_score()

  counter(page).update(0)
  // 页眉
  show: _postgraduate_report_set_paper_page_header

  // 目录与摘要的页脚
  show: _set_paper_page_footer_pre
  // 整体段落与页面设置
  show: _set_paper_page_par

  set page(
    margin: if asymmetric_margin {
      (left: 2.7cm, right: 1.1cm, top: 1.6cm, bottom: 1.5cm)
    } else {
      auto
    }
  )

  // 原创性声明与摘要间的空页
  // pagebreak()
  counter(page).update(1)

  // 摘要
  if abstract != [] {
    zh_abstract_page(abstract, keywords: keywords)
    pagebreak()
  }

  if abstract_en != [] {
    en_abstract_page(abstract_en, keywords: keywords_en)
    pagebreak()
  }


  // 目录
  chinese_outline()

  /* 正文 */

  // 正文的页脚
  show: _set_paper_page_footer_main

  counter(page).update(1)

  body

  postgraduate-report-last-page(date)
}
