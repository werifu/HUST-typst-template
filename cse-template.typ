#import "@preview/lovelace:0.2.0": *
#import "fonts/font_def.typ": *
#import "pages/acknowledgement.typ": acknowledgement
#import "pages/chinese_outline.typ": chinese_outline
#import "pages/declaration.typ": declaration
#import "pages/zh_abstract_page.typ": zh_abstract_page
#import "pages/en_abstract_page.typ": en_abstract_page
#import "pages/references.typ": _set_references
#import "utilities/three_line_table.typ": three_line_table
#import "utilities/indent_funs.typ": *
#import "utilities/set_heading.typ": _set_heading
#import "utilities/set_figure.typ": _set_figure
#import "utilities/set_numbering.typ": _set_numbering

#let bib_cite(..names) = {
  for name in names.pos() {
    cite(name)
  }
}

#let project(
  anonymous: false, // 是否匿名化处理
  title: "",
  abstract_zh: [],
  abstract_en: [],
  keywords_zh: (),
  keywords_en: (),
  school: "",
  author: "",
  id: "",
  mentor: "",
  class: "",
  date: (1926, 8, 17),
  body,
) = {
  // 设置标题, 需要在图表前设置
  show: _set_heading
  // 图表公式的排版
  show: _set_figure
  show: _set_numbering
  // 参考文献
  show: _set_references.with(csl_style: "hust-cse-ug.csl")

  set page(paper: "a4", margin: (
    top: 2.5cm,
    bottom: 2.5cm,
    left: 3cm,
    right: 3cm
  ))

  // 封面
  align(center)[
    // hust logo
    #v(20pt)

    // 匿名化处理需要去掉个人、机构信息
    #let logo_path = if not anonymous {
      "./assets/cse-hust.png"
    } else {
      "./assets/black.png"
    }
    #image(logo_path, width: 55%, height: 7%)

    #v(40pt)

    #text(
      size: 36pt,
      font: zhongsong,
      weight: "bold"
    )[本科生毕业设计(论文)]

    #v(40pt)

    #text(
      font: heiti,
      size: 22pt,
    )[
      #title
    ]

    #v(80pt)

    #let info_value(body) = {
      rect(
        width: 100%,
        inset: 2pt,
        stroke: (
          bottom: 1pt + black
        ),
        text(
          font: zhongsong,
          size: 16pt,
          bottom-edge: "descender"
        )[
          #body
        ]
      ) 
    }
    
    #let info_key(body) = {
      rect(width: 100%, inset: 2pt, 
       stroke: none,
       text(
        font: zhongsong,
        size: 16pt,
        body
      ))
    }

    #grid(
      columns: (70pt, 180pt),
      rows: (40pt, 40pt),
      gutter: 3pt,
      info_key("院　　系"),
      info_value(if not anonymous { school } else { "██████████" }),
      info_key("专业班级"),
      info_value(if not anonymous { class } else { "██████████" }),
      info_key("姓　　名"),
      info_value(if not anonymous { author } else { "██████████" }),
      info_key("学　　号"),
      info_value(if not anonymous { id } else { "██████████" }),
      info_key("指导教师"),
      info_value(if not anonymous { mentor } else { "██████████" }),
    )

    #v(30pt)
    #text(
      font: zhongsong,
      size: 16pt,
    )[
      #date.at(0) 年 #date.at(1) 月 #date.at(2) 日
    ]
    #pagebreak()
  ]

  // 原创性声明
  declaration(anonymous: anonymous)
  pagebreak()

  counter(page).update(0)
  // 页眉
  set page(
    header: {
      set text(font: songti, 10pt, baseline: 8pt, spacing: 3pt)
      set align(center)
      if not anonymous {
        [华 中 科 技 大 学 毕 业 设 计 (论 文)]
      } else {
        [█████████████████████████]
      }
      
      line(length: 100%, stroke: 0.7pt)
    }
  )

  // 页脚
  // 封面不算页数
  set page(
    footer: {
      set align(center)
      
      grid(
        columns: (5fr, 1fr, 5fr),
        line(length: 100%, stroke: 0.7pt),
        text(font: songti, 10pt, baseline: -3pt, 
          counter(page).display("I")
        ),
        line(length: 100%, stroke: 0.7pt)
      )
    }
  )

  set text(font: songti, 12pt)
  set par(justify: true, leading: 1.24em, first-line-indent: 2em)
  show par: set block(spacing: 1.24em)

  show: _fix_indent

  pagebreak()
  counter(page).update(1)

  // 摘要
  zh_abstract_page(abstract_zh, keywords: keywords_zh)

  pagebreak()

  // abstract
  en_abstract_page(abstract_en, keywords: keywords_en)

  pagebreak()

  // 目录
  chinese_outline()

  // 正文的页脚
  
  set page(
    footer: {
      set align(center)
      
      grid(
        columns: (5fr, 1fr, 5fr),
        line(length: 100%, stroke: 0.7pt),
        text(font: songti, 10pt, baseline: -3pt, 
          counter(page).display("1")
        ),
        line(length: 100%, stroke: 0.7pt)
      )
    }
  )


  counter(page).update(1)

  // 代码块(TODO: 加入行数)
  show raw: it => {
    set text(font: songti, 12pt)
    set block(inset: 5pt, fill: rgb(217, 217, 217, 1), width: 100%)
    it
  }

  body
}
