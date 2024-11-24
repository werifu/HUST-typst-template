#import "@preview/lovelace:0.2.0": *

#let heiti = ("Times New Roman", "Heiti SC", "Heiti TC", "SimHei")
#let songti = ("Times New Roman", "Songti SC", "Songti TC", "SimSun")
#let zhongsong = ("Times New Roman", "STZhongsong", "SimSun")

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
#let _set_numbering(body) = {
  import "@preview/i-figured:0.2.4"

  set heading(numbering: "1.1.1")

  show heading: i-figured.reset-counters
  show figure: i-figured.show-figure.with(numbering: "1-1")
  show math.equation: i-figured.show-equation.with(numbering: "(1-1)")

  body
}

// 设置图表
#let _set_figure(body) = {
  // 设置前缀
  show figure.where(kind: image): set figure(supplement: [图])

  show figure.where(kind: table): set figure(supplement: [表])
  show figure.where(kind: table): set figure.caption(position: top)

  // 使用正确的编号与图表标题字体及分隔符
  show figure.caption: set text(font: heiti)
  set figure.caption(separator: "　")

  set heading(supplement: [节])
  set math.equation(supplement: [公式])

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
      let before_toc = query(heading.where(outlined: true).before(loc), loc).find(one => {
        one.body == el.body
      }) != none
      let page_num = if before_toc {
        numbering("I", counter(page).at(el.location()).first())
      } else {
        counter(page).at(el.location()).first()
      }

      link(el.location())[#{
          // acknoledgement has no numbering
          let chapt_num = if el.numbering != none {
            numbering(el.numbering, ..counter(heading).at(el.location()))
          } else {
            none
          }

          if el.level == 1 {
            set text(weight: "black")
            if chapt_num == none { } else {
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

  set par(justify: false, leading: 1.24em, first-line-indent: 2em)

  bibliography(path, title: "参考文献", style: "./hust-cse-ug.csl")
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
      #keywords.join("；")
    ]
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
      #keywords.join("; ")
    ]
  ]
}

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

  // 图表公式的排版
  show: _set_figure
  show: _set_numbering

  set page(
    paper: "a4",
    margin: (
      top: 2.5cm,
      bottom: 2.5cm,
      left: 3cm,
      right: 3cm,
    ),
  )

  set page(
    paper: "a4",
    margin: (
      top: 2.5cm,
      bottom: 2.5cm,
      left: 3cm,
      right: 3cm,
    ),
  )

  // 封面
  align(center)[
    #set text(
      font: songti,
      size: 16pt,
    )
    #v(100pt)

    #text(font: songti, size: 26pt)[
      #align(center)[
        华 中 科 技 大 学

        研究生课程考试答题本
      ]
    ]

    #v(220pt)

    #align(center)[

      #let info_value(body) = {
        rect(
          width: 100%,
          inset: 2pt,
          stroke: (
            bottom: 1pt + black,
          ),
          text(
            font: songti,
            size: 16pt,
            bottom-edge: "descender",
          )[
            #body
          ],
        )
      }

      #let info_key(body) = {
        rect(
          width: 100%,
          inset: 2pt,
          stroke: none,
          text(
            font: songti,
            size: 16pt,
            bottom-edge: "descender",
          )[
            #body
          ],
        )
      }

      #block(width: 18em)[
        #grid(
          columns: (4.3em, 1fr),
          rows: (1.8em),
          gutter: 3pt,
          info_key("考生姓名"), info_value([#author]),
          info_key("考生学号"), info_value([#id]),
          info_key("系、年级"), info_value([#grade]),
          info_key("类        别"), info_value([#kind]),
          info_key("考试科目"), info_value([#course]),
          info_key("考试日期"), info_value([#date.at(0) 年 #date.at(1) 月 #date.at(2) 日]),
        )]]

    #pagebreak()
  ]


  // 评分页
  align(center)[
    #text(size: 22pt, font: songti, "评      分")

    #set text(font: songti, size: 15pt)

    #table(
      columns: (93pt, 93pt, 93pt, 93pt),
      inset: (x: 16pt, y:14pt),
      align: (center, center),
      "题   号", "得   分", "题   号", "得   分",
      "", "", "", "",
      "", "", "", "",
      "", "", "", "",
      "", "", "", "",
      "", "", "", "",
      "", "", "", "",
      "", "", "", "",
      "", "", "", "",
    )

    #v(10pt)

    #table(
      columns: (186pt, 186pt),
      inset: (x: 5pt, y: 14pt),
      align: (left, left),
      "总分：", "评卷人：",
    )

    #set text(font: songti, size: 12pt)
    #align(left)[
      #par(
        leading: 1.24em,
      )[
        注：1、无评卷人签名试卷无效。 \
      #text("  2、必须用钢笔或圆珠笔阅卷，使用红色。用铅笔阅卷无效。")
      ]

    ]

  ]

  counter(page).update(0)
  // 页眉
  set page(header: {
    set text(font: songti, 10pt, baseline: 8pt, spacing: 3pt)
    set align(center)
    if not anonymous {
      [华 中 科 技 大 学 研 究 生 课 程 考 试 答 题 本]
    } else {
      [█████████████████████████]
    }

    line(length: 100%, stroke: 0.7pt)
  })

  // 页脚
  // 封面不算页数
  set page(footer: {
    set align(center)

    grid(
      columns: (5fr, 1fr, 5fr),
      line(length: 100%, stroke: 0.7pt),
      text(font: songti, 10pt, baseline: -3pt, counter(page).display("I")),
      line(length: 100%, stroke: 0.7pt),
    )
  })

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
  show heading: it => (
    {
      set text(weight: "bold", font: heiti, size: 12pt)
      set block(above: 1.5em, below: 1.5em)
      it
    } + empty_par()
  )
  show figure: it => {
    it + empty_par()
  }
  show math.equation: it => {
    it + empty_par()
  }

  pagebreak()
  counter(page).update(1)

  // 摘要
  zh_abstract_page(abstract, keywords: keywords)

  pagebreak()

  // 目录
  chinese_outline()

  // 正文的页脚

  set page(footer: {
    set align(center)

    grid(
      columns: (5fr, 1fr, 5fr),
      line(length: 100%, stroke: 0.7pt),
      text(font: songti, 10pt, baseline: -3pt, counter(page).display("1")),
      line(length: 100%, stroke: 0.7pt),
    )
  })


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
    stroke: (bottom: 1pt),
    [#content],
  )
}

#let tlt_cell(content) = {
  set align(center)
  rect(
    width: 100%,
    stroke: none,
    [#content],
  )
}

#let tlt_row(r) = {
  (..r.map(tlt_cell).flatten(),)
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
    ),
  )
}

