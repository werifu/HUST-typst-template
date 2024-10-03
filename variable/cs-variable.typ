#import "../fonts/font-def.typ": *

// 页眉字体
#let huawenkaiti = ("Times New Roman", "STKaiti")

// 计院风格中文摘要
#let cs_zh_abstract_page(abstract, keywords: ()) = {
  set heading(level: 1, numbering: none)
  show <_zh_abstract_>: {
    align(center)[
      #text(font: heiti, size: 18pt, "摘　　要")
    ]
  }
  [= 摘要 <_zh_abstract_>]

  set text(font: songti, size: 12pt)

  abstract
  par(first-line-indent: 0em)[
    #text(weight: "bold", font: heiti, size: 12pt)[
      关键词：
    ]
    #keywords.join("；")
  ]
}

// 计院风格英文摘要
#let cs_en_abstract_page(abstract, keywords: ()) = {
  set heading(level: 1, numbering: none)
  show <_en_abstract_>: {
    align(center)[
      #text(font: heiti, size: 18pt, "Abstract")
    ]
  }
  [= Abstract <_en_abstract_>]

  set text(font: songti, size: 12pt)

  abstract
  par(first-line-indent: 0em)[
    #text(weight: "bold", font: heiti, size: 12pt)[
      Key Words: 
    ]
    #keywords.join(", ")
  ]
}

// 计院风格页眉
#let _cs_set_paper_page_header(anonymous: false, body) = {
  set page(
    header: {
      set text(font: huawenkaiti, 16pt, baseline: 12pt, spacing: 16pt, fill: rgb("#960000"))
      set align(center)
      if not anonymous {
        [华 中 科 技 大 学 毕 业 设 计]
      } else {
        set text(fill: black)
        [█████████████████████████]
      }
      
      line(length: 100%, stroke: 0.7pt)
    }
  )

  body
}
