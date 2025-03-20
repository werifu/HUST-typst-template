#import "../fonts/font-def.typ": *
#import "../utilities/indent-funs.typ": empty_par

// aia院风格中文摘要
#let aia_zh_abstract_page(abstract, keywords: ()) = {
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

// aia院风格英文摘要
#let aia_en_abstract_page(abstract, keywords: ()) = {
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

// aia院风格封面
#let aia_paper_cover(cover_logo_path:"../assets/cse-hust.png", anonymous, title, school, class, author, id, mentor, date) = {
  align(center)[
    // hust logo
    #v(20pt)

    // 匿名化处理需要去掉个人、机构信息
    #let logo_path = if not anonymous {
      cover_logo_path
    } else {
      "../assets/black.png"
    }
    #image(logo_path, width: 55%, height: 7%)

    #v(40pt)

    #text(
      size: 36pt,
      font: zhongsong,
      weight: "bold"
    )[本科生毕业设计[论文]]

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
}

#let aia_acknowledgement(body) = {
  // 这个取消目录里的 numbering
  set heading(level: 1, numbering: none)
  show <_thx>: {
    // 这个取消展示时的 numbering
    set heading(level: 1, numbering: none)
    set align(center)
    set text(weight: "bold", font: heiti, size: 18pt)

    "致谢"
  } + empty_par()

  
  [= 致谢 <_thx>]

  body
}