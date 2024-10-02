#import "@preview/lovelace:0.2.0": *


#let huawenkaiti = ("Times New Roman", "STKaiti")
#let heiti = ("Times New Roman", "Heiti SC", "Heiti TC", "SimHei")
#let songti = ("Times New Roman", "Songti SC", "Songti TC", "SimSun")
#let zhongsong = ("STZhongsong", "Times New Roman")

#let bib_cite(..names) = {
  for name in names.pos() {
    cite(name)
  }
}

#let indent() = {
  box(width: 2em)
}

#let indent_par(body) = {
  box(width: 1.8em)
  body
}

// 设置编号 (引用时, 需要使用标签)
#let _set_numbering(body) ={
    import "@preview/i-figured:0.2.4"

    set heading(numbering: "1.1.1")

    show heading: i-figured.reset-counters
    show figure: i-figured.show-figure.with(numbering: "1-1")
    show math.equation: i-figured.show-equation.with(numbering: "(1-1)")


    body
}

// 设置图表
#let _set_figure(body) ={
    show figure.where(kind: image): set figure(supplement: [图])

    show figure.where(kind: table): set figure(supplement: [表])
    show figure.where(kind: table): set figure.caption(position: top)

    // 使用正确的编号与图表标题字体及分隔符
    show figure.caption: set text(font: heiti)
    set figure.caption(separator: "　")

    set heading(supplement: [节])
    set math.equation(supplement: [式])

    body
}
#let empty_par() = {
  v(-1em)
  box()
}

// inspired from https://github.com/lucifer1004/pkuthss-typst.git
#let chinese_outline() = {
  align(center)[
    #text(font: heiti, size: 18pt, "目　　录")
  ]

  set text(font: songti, size: 12pt)
  // 临时取消目录的首行缩进
  set par(leading: 1.24em, first-line-indent: 0pt)
  locate(loc => {
    let elements = query(heading.where(outlined: true), loc)
    for el in elements {
      // 计算机学院要求不出现三级以上标题
      if el.level > 2 {
        continue
      }

      // 是否有 el 位于前面，前面的目录中用拉丁数字，后面的用阿拉伯数字
      let before_toc = query(heading.where(outlined: true).before(loc), loc).find((one) => {one.body == el.body}) != none
      let page_num = if before_toc {
        numbering("I", counter(page).at(el.location()).first())
      } else {
        counter(page).at(el.location()).first()
      }

      link(el.location())[#{
        // acknoledgement has no numbering
        let chapt_num = if el.numbering != none {
          numbering(el.numbering, ..counter(heading).at(el.location()))
        } else {none}

        if el.level == 1 {
          set text(weight: "black")
          if chapt_num == none {} else {
            chapt_num
            "　　"
          }
          el.body
        } else {
          chapt_num
          "　"
          el.body
        }
      }]

      // 填充 ......
      box(width: 1fr, h(0.5em) + box(width: 1fr, repeat[.]) + h(0.5em))
      [#page_num]
      linebreak()
    }
  })
}

// 原创性声明和授权书
#let declaration(anonymous: false) = {
  set text(font: songti, 12pt)

  v(5em)
  align(center)[
    #text(font: heiti, size: 18pt)[
      学位论文原创性声明
    ]
  ]
  text(font: songti, size: 12pt)[
    #set par(justify: false, leading: 1.24em, first-line-indent: 2em)
    本人郑重声明：所呈交的论文是本人在导师的指导下独立进行研究所取得的 研究成果。除了文中特别加以标注引用的内容外，本论文不包括任何其他个人或集体已经发表或撰写的成果作品。本人完全意识到本声明的法律后果由本人承担。
  ]
  v(2em)
  align(right)[
    #if not anonymous {
      text("作者签名：　　　　　　　年　　月　　日")
    } else {
      text("作者签名：██████████年███月███日")
    }
  ]
  
  v(6em)
  align(center)[
    #text(font: heiti, size: 18pt)[
      学位论文版权使用授权书
    ]
  ]
  text(font: songti, size: 12pt)[
    #set par(justify: false, leading: 1.24em, first-line-indent: 2em)
    #if not anonymous [
      本学位论文作者完全了解学校有关保障、使用学位论文的规定，同意学校保留并向有关学位论文管理部门或机构送交论文的复印件和电子版，允许论文被查阅和借阅。本人授权省级优秀学士论文评选机构将本学位论文的全部或部分内容编入有关数据进行检索，可以采用影印、缩印或扫描等复制手段保存和汇编本学位论文。
    ] else [
      本学位论文作者完全了解学校有关保障、使用学位论文的规定，同意学校保留并向有关学位论文管理部门或机构送交论文的复印件和电子版，允许论文被查阅和借阅。本人授权█████████████将本学位论文的全部或部分内容编入有关数据进行检索，可以采用影印、缩印或扫描等复制手段保存和汇编本学位论文。
    ]
    

    学位论文属于 1、保密 □，在#h(3em)年解密后适用本授权书。

    #h(6.3em) 2、不保密 □

    #h(6.3em)请在以上相应方框内打 “√”
  ]

  v(3em)
  align(right)[
    #if not anonymous {
      text("作者签名：　　　　　　　年　　月　　日")
    } else {
      text("作者签名：██████████年███月███日")
    }
  ]

  align(right)[
    #if not anonymous {
      text("导师签名：　　　　　　　年　　月　　日")
    } else {
      text("导师签名：██████████年███月███日")
    }
  ]
}

// 参考文献
#let references(path) = {
  // 这个取消目录里的 numbering
  set heading(level: 1, numbering: none)

  set par(justify: true, leading: 1.24em, first-line-indent: 2em)

  bibliography(path, title:"参考文献", style: "./hust-cs.csl")
}


// 致谢，请手动调用
#let acknowledgement(body) = {
  // 这个取消目录里的 numbering
  set heading(level: 1, numbering: none)
  show <_thx>: {
    // 这个取消展示时的 numbering
    set heading(level: 1, numbering: none)
    set align(center)
    set text(weight: "bold", font: heiti, size: 18pt)

    "致　　谢"
  } + empty_par()

  
  [= 致谢 <_thx>]

  body
}

// 中文摘要
#let zh_abstract_page(abstract, keywords: ()) = {
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

// 英文摘要
#let en_abstract_page(abstract, keywords: ()) = {
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
  // 图表公式的排版
  show: _set_figure
  show: _set_numbering

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
      "./assets/cs-hust.png"
    } else {
      "./assets/black.png"
    }
    #image(logo_path, width: 55%, height: 7%)

    #v(40pt)

    #text(
      size: 36pt,
      font: zhongsong,
      weight: "bold"
    )[本科生毕业设计]

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
    #pagebreak()
  ]

  // 原创性声明
  declaration(anonymous: anonymous)
  pagebreak()

  counter(page).update(0)
  // 页眉
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

  set heading(numbering: (..nums) => {
    nums.pos().map(str).join(".") + "　"
  })
  show heading.where(level: 1): it => {
    set align(center)
    set text(weight: "bold", font: heiti, size: 18pt)
    set block(spacing: 1.5em)
    it
  }
  show heading.where(level: 2): it => {
    set text(weight: "bold", font: heiti, size: 14pt)
    set block(above: 1.5em, below: 1.5em)
    it
  }

  // 首段不缩进，手动加上 box
  show heading: it => {
    set text(weight: "bold", font: heiti, size: 12pt)
    set block(above: 1.5em, below: 1.5em)
    it
  } + empty_par()
  show figure: it => {
    it + empty_par()
  }
  show math.equation: it => {
    it + empty_par()
  }

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

// 三线表
#let tlt_header(content) = {
  set align(center)
  rect(
    width: 100%,
    stroke: (bottom: 0pt), 
    [#content],
  )
}

#let tlt_cell(content) = {
  set align(center)
  rect(
    width: 100%,
    stroke: none,
    [#content]
  )
}

#let tlt_row(r) = {
  (..r.map(tlt_cell).flatten())
}

#let three_line_table(values) = {
  rect(
    stroke: (bottom: 1.5pt, top: 1.5pt),
    inset: 0pt,
    outset: 0pt,
    grid(
      columns: (auto),
      rows: (auto),
      align: center + horizon,
      // table title
      grid(
        stroke: (bottom: 0.75pt),
        columns: values.at(0).len(),
        ..values.at(0).map(tlt_header).flatten()
      ),

      grid(
        columns: values.at(0).len(),
        ..values.slice(1).map(tlt_row).flatten()
      ),
    )
  )
}

