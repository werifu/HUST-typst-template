#let heiti = ("Times New Roman", "Heiti SC", "Heiti TC")
#let songti = ("Times New Roman", "Songti SC", "Songti TC")

#let indent_par(body) = {
  box(width: 1.8em)
  body
}

#let equation_num(_) = {
  locate(loc => {
    let chapt = counter(heading).at(loc).at(0)
    let c = counter("equation-chapter" + str(chapt))
    let n = c.at(loc).at(0)
    "(" + str(chapt) + "-" + str(n + 1) + ")"
  })
}

#let table_num(_) = {
  locate(loc => {
    let chapt = counter(heading).at(loc).at(0)
    let c = counter("table-chapter" + str(chapt))
    let n = c.at(loc).at(0)
    str(chapt) + "-" + str(n + 1)
  })
}

#let image_num(_) = {
  locate(loc => {
    let chapt = counter(heading).at(loc).at(0)
    let c = counter("image-chapter" + str(chapt))
    let n = c.at(loc).at(0)
    str(chapt) + "-" + str(n + 1)
  })
}


#let equation(equation, caption: "") = {
  figure(
    equation,
    caption: caption,
    supplement: [公式],
    numbering: equation_num,
    kind: "equation",
  )
}

#let tbl(tbl, caption: "") = {
  figure(
    tbl,
    caption: caption,
    supplement: [表],
    numbering: table_num,
    kind: "table",
  )
}

#let img(img, caption: "") = {
  figure(
    img,
    caption: caption,
    supplement: [图],
    numbering: image_num,
    kind: "image",
  )
}


#let empty_par() = {
  v(-1em)
  box()
}

#let toc() = {
  v(1em)

  // HUST 的反人类目录还包括出现在目录前的摘要……硬编码吧
  align(center)[
    #text(font: heiti, size: 18pt, "目　　录")
  ]

  parbreak()

  set text(font: songti, size: 12pt)
  [摘要 ] + [.] * 130 + [ I]
  parbreak()

  text(weight: "bold")[Abstract ] + [.] * 122 + [ II]

  show outline: it => {
    set text(font: songti, size: 12pt)
    set par(leading: 1.5em)
    it
    pagebreak()
  }
  outline(
    title: none
  )
}

// 原创性声明和授权书
#let declaration() = {
  set text(font: songti, 12pt)

  show par: it => {
    it
    v(5pt)
  }

  v(3em)
  align(center)[
    #text(font: heiti, size: 18pt)[
      学位论文原创性声明
    ]
  ]
  text(font: songti, size: 12pt)[
    #set par(justify: false, leading: 1.5em, first-line-indent: 2em)
    本人郑重声明：所呈交的论文是本人在导师的指导下独立进行研究所取得的 研究成果。除了文中特别加以标注引用的内容外，本论文不包括任何其他个人或集体已经发表或撰写的成果作品。本人完全意识到本声明的法律后果由本人承担。
  ]
  v(2em)
  align(right)[
    #text("作者签名：　　　　　　　年　　月　　日")
  ]
  
  v(6em)
  align(center)[
    #text(font: heiti, size: 18pt)[
      学位论文版权使用授权书
    ]
  ]
  text(font: songti, size: 12pt)[
    #set par(justify: false, leading: 1.5em, first-line-indent: 2em)
    本学位论文作者完全了解学校有关保障、使用学位论文的规定，同意学校保留并向有关学位论文管理部门或机构送交论文的复印件和电子版，允许论文被查阅和借阅。本人授权省级优秀学士论文评选机构将本学位论文的全部或部分内容编入有关数据进行检索，可以采用影印、缩印或扫描等复制手段保存和汇编本学位论文。

    学位论文属于 1、保密 □，在#h(3em)年解密后适用本授权书。

    #h(6.3em) 2、不保密 □

    #h(6.3em)请在以上相应方框内打 “√”
  ]

  v(3em)
  align(right)[
    #text("作者签名：　　　　　　　年　　月　　日")
  ]

  align(right)[
    #text("导师签名：　　　　　　　年　　月　　日")
  ]
}

// 参考文献
#let references(path) = {
  // 这个取消目录里的 numbering
  set heading(level: 1, numbering: none)

  set par(justify: false, leading: 1.5em, first-line-indent: 2em)
  show par: it => {
    it
    v(5pt)
  }

  bibliography(path, title:"参考文献")
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
  set par(justify: false, leading: 1.5em, first-line-indent: 2em)
  show par: it => {
    it
    v(5pt)
  }
  body
}

// 中文摘要
#let zh_abstract_page(abstract, keywords: ()) = {
  v(2em)

  align(center)[
    #text(font: heiti, size: 18pt, "摘　　要")
  ]

  set text(font: songti, size: 12pt)
  set par(justify: false, leading: 1.5em, first-line-indent: 2em)
  show par: it => {
    it
    v(5pt)
  }

  abstract
  par(first-line-indent: 0em)[
    #text(weight: "bold", font: heiti, size: 12pt)[
      关键词：
      #keywords.join("；")
    ]
  ]
}

// 英文摘要
#let en_abstract_page(abstract, keywords: ()) = {
  v(2em)

  align(center)[
    #text(weight: "bold", font: heiti, size: 18pt, "Abstract")
  ]

  set text(font: songti, size: 12pt)
  set par(justify: false, leading: 1.5em, first-line-indent: 2em)
  show par: it => {
    it
    v(5pt)
  }

  abstract
  par(first-line-indent: 0em)[
    #text(weight: "bold", font: heiti, size: 12pt)[
      Key Words: 
      #keywords.join("; ")
    ]
  ]
}

#let project(
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
  show figure: it => {
    set align(center)
    if it.kind == "image" {
      set text(font: heiti, size: 12pt)
      it.body
      it.supplement
      " " + it.counter.display(it.numbering)
      "　" + it.caption
      locate(loc => {
        let chapt = counter(heading).at(loc).at(0)
        let c = counter("image-chapter" + str(chapt))
        c.step()
      })
    } else if it.kind == "table" {
      set text(font: heiti, size: 12pt)
      it.supplement
      " " + it.counter.display(it.numbering)
      "　" + it.caption
      set text(font: songti, size: 10.5pt)
      it.body
      locate(loc => {
        let chapt = counter(heading).at(loc).at(0)
        let c = counter("table-chapter" + str(chapt))
        c.step()
      })
    } else if it.kind == "equation" {
      // 通过大比例来达到中间和靠右的排布
      grid(
        columns: (20fr, 1fr),
        it.body,
        align(center + horizon, 
          it.counter.display(it.numbering)
        )
      )
      locate(loc => {
        let chapt = counter(heading).at(loc).at(0)
        let c = counter("equation-chapter" + str(chapt))
        c.step()
      })
    } else {
      it
    }
  }
  set page(paper: "a4", margin: (
    top: 2.5cm,
    bottom: 2.5cm,
    left: 3cm,
    right: 3cm
  ))

  // 封面
  align(center)[
    // hust logo
    #v(30pt)

    #image("./assets/hust.png", width: 55%)

    #v(50pt)

    #text(
      size: 36pt,
      font: "Songti SC",
      weight: "bold"
    )[本科生毕业设计(论文)]

    #v(40pt)

    #text(
      font: heiti,
      size: 20pt,
    )[
      #title
    ]

    #v(100pt)

    #let info_value(body) = {
      rect(
        width: 100%,
        inset: 2pt,
        stroke: (
          bottom: 1pt + black
        ),
        text(
          font: songti,
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
        font: songti,
        size: 16pt,
        body
      ))
    }

    #grid(
      columns: (70pt, 180pt),
      rows: (40pt, 40pt),
      gutter: 3pt,
      info_key("院　　系"),
      info_value(school),
      info_key("专业班级"),
      info_value(class),
      info_key("姓　　名"),
      info_value(author),
      info_key("学　　号"),
      info_value(id),
      info_key("指导教师"),
      info_value(mentor),
    )

    #v(40pt)
    #text(
      font: songti,
      size: 16pt,
    )[
      #date.at(0) 年 #date.at(1) 月 #date.at(2) 日
    ]
  ]
  
  counter(page).update(0)
  // 页眉
  set page(
    header: {
      set text(font: songti, 10pt, baseline: 8pt, spacing: 3pt)
      set align(center)
      [华 中 科 技 大 学 毕 业 设 计 (论 文)]
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
        line(length: 200pt, stroke: 0.7pt),
        text(font: songti, 10pt, baseline: -3pt, 
          counter(page).display("I")
        ),
        line(length: 200pt, stroke: 0.7pt)
      )
    }
  )

  // 原创性声明
  declaration()


  pagebreak()
  counter(page).update(1)

  // 摘要
  zh_abstract_page(abstract_zh, keywords: keywords_zh)

  pagebreak()

  // abstract
  en_abstract_page(abstract_en, keywords: keywords_en)

  pagebreak()

  // 目录
  toc()

  // 正文的页脚
  
  set page(
    footer: {
      set align(center)
      
      grid(
        columns: (5fr, 1fr, 5fr),
        line(length: 200pt, stroke: 0.7pt),
        text(font: songti, 10pt, baseline: -3pt, 
          counter(page).display("1")
        ),
        line(length: 200pt, stroke: 0.7pt)
      )
    }
  )

  set heading(numbering: (..nums) => {
    nums.pos().map(str).join(".") + "　"
  })
  show heading.where(level: 1): it => {
    set align(center)
    set text(weight: "bold", font: heiti, size: 18pt)
    it
  }
  show heading.where(level: 2): it => {
    set text(weight: "bold", font: heiti, size: 14pt)
    it
  }

  // 首段不缩进，手动加上 box
  show heading: it => {
    set text(weight: "bold", font: heiti, size: 12pt)
    it
  } + empty_par()

  set text(font: songti, 12pt)
  set par(justify: false, leading: 1.5em, first-line-indent: 2em)
  show par: it => {
    it
    // 分段时的行距
    v(5pt)
  }
  counter(page).update(1)

  body
}

// 三线表
#let tlt_header(content) = {
  set align(center)
  rect(
    width: 100%,
    stroke: (bottom: 1pt),
    [#content],
  )
}

#let tlt_cell(content) = {
  set align(left)
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
    stroke: (bottom: 1pt, top: 1pt),
    inset: 0pt,
    outset: 0pt,
    grid(
      columns: (auto),
      rows: (auto),
      // table title
      grid(
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

