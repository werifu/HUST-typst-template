#import "../fonts/font-def.typ": *

#let master_exam_cover(
  author: "",
  grade: "",
  kind: "",
  id: "",
  course: "",
  date: (1926, 8, 17),
) = {
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

}


#let master_exam_score() = {
  align(center)[
    #text(size: 22pt, font: songti, "评      分")

    #set text(font: songti, size: 15pt)

    #table(
      columns: (93pt, 93pt, 93pt, 93pt),
      inset: (x: 16pt, y: 14pt),
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
      #par(leading: 1.24em)[
        注：1、无评卷人签名试卷无效。 \
        #text("        2、必须用钢笔或圆珠笔阅卷，使用红色。用铅笔阅卷无效。")
      ]

    ]

  ]
}

#let _master_exam_set_paper_page_header(anonymous: false, body) = {
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

  body
}
