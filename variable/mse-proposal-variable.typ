#import "../fonts/font-def.typ": *
#import "@preview/tablex:0.0.9": tablex, rowspanx, colspanx

#let mse_proposal_paper_cover(cover_logo_path: "../assets/cs-hust.png", anonymous, title, school, class, author, id, mentor, date) = {
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
      size: 22pt,
      font: zhongsong,
      weight: "bold"
    )[本科毕业设计（论文）开题报告]

    #v(40pt)

    #text(
      font: zhongsong,
      size: 16pt,
    )[
      题#h(2em)目：#title
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

// 开题报告填写要求
#let mse_proposal_declaration() = {
  
  set par(justify: true, leading: 20pt)

  v(1em)

  text(
    font: zhongsong,
    size: 16pt,
    weight: "bold"
  )[#align(center)[开题报告填写要求]
    
  ]
  
  v(1em)

  text(
    font: songti,
    size: 14.5pt,
  )[
    #set enum(numbering: "一、 ")
    + 开题报告主要内容：\
      1\. 课题来源、目的、意义。\ 
      2\. 国内外研究现况及发展趋势。\ 
      3\. 预计达到的目标、关键理论和技术、主要研究内容、完成课题的方案及主要措施。\ 
      4\. 课题研究进度安排。\ 
      5\. 主要参考文献。\ 
    + 报告内容用小四号宋体字编辑，采用 A4 号纸双面打印，封面与封底采用浅蓝色封面纸（卡纸）打印。要求内容明确，语句通顺。
    + 指导教师评语、教研室（系、所）或开题报告答辩小组审核意见用蓝、黑钢笔手写或小四号宋体字编辑，签名必须手写。
    + 理、工、医类要求字数在 3000 字左右，文、管类要求字数在 2000 字左右。
    + 开题报告应在第八学期第二周之前完成。
  ]
}


#let _mse_proposal_set_heading(body) ={
    set heading(numbering: "1.1.1.1.")
    show heading.where(level: 1): set heading(numbering: "一、")
    set heading(supplement: [节])

    // 参考自 https://github.com/nju-lug/modern-nju-thesis/blob/main/utils/custom-heading.typ
    show heading: it =>{
        if it != none {
        set par(first-line-indent: 0em)
        if it.has("numbering") and it.numbering != none {
          numbering(it.numbering, ..counter(heading).at(it.location()))
          if it.level != 1 {[　 ]}
        }
        it.body
    } else {
        ""
    }
    }
    show heading.where(level: 1): it => {
        // set align(center)
        set text(weight: "bold", font: songti, size: 14pt)
        set block(spacing: 1.5em)
        it
    }
    show heading.where(level: 2): it => {
        set text(weight: "bold", font: songti, size: 12pt)
        set block(above: 1.5em, below: 1.5em)
        it
    }
    show heading.where(level: 3): it => {
        set text(weight: "bold", font: songti, size: 12pt)
        set block(above: 1.5em, below: 1.5em)
        it
    }
    show heading.where(level: 4): it => {
        set text(weight: "bold", font: songti, size: 12pt)
        set block(above: 1.5em, below: 1.5em)
        it
    }

    body
}

// 页眉
#let _mse_proposal_set_paper_page_header(anonymous: false, body) = {
    set page(
        header: {
        set text(font: songti, 10pt, baseline: 8pt, spacing: 3pt)
        set align(center)
        if not anonymous {
            [华中科技大学本科毕业设计（论文）开题报告]
        } else {
            [█████████████████████████]
        }

        v(1em)
        
        line(length: 100%, stroke: 0.7pt)
        }
    )

    body
}

#let _mse_proposal_set_references(csl_style: "pages/hust-cse-ug.csl", body) = {
    set bibliography(title: "主要参考文献", style: csl_style)

    show bibliography: it =>{
        set heading(level: 1)

        set par(justify: true, leading: 1.0em, first-line-indent: 2em)

        it
    }

    body
}

// 正文部分页脚
#let _mse_proposal_set_paper_page_footer_main(body) = {
    set page(
        footer: {
        set align(center)
        
        grid(
            columns: (5fr, 1fr, 5fr),
            line(length: 100%, stroke: 0.7pt + rgb(168, 193, 223)),
            text(font: songti, 10pt, baseline: -3pt, 
            counter(page).display("1")
            ),
            line(length: 100%, stroke: 0.7pt + rgb(168, 193, 223))
        )
        }
    )

    body
}

// 开题报告评审表
#let mse_proposal_inspect(with_annotation: true) = {

  let tb1()={
    set text(size: 10.5pt)

    [*指导教师评语*]

    align(left + horizon)[
    #enum(spacing: 0.7em)[学生前期表现情况。][是否具备开始毕业设计（论文）条件？是否同意开始毕业设计（论文）？][不足及建议。]    
    ]

  }

  let tb2()={
    // 标注楷体
    if with_annotation {
      
    } 

    v(0.5em)

    align(left + top)[
    #if with_annotation [
      #let huawenkaiti = ("Timse New Roman", "STKaiti")
      #text(size: 10.5pt, fill: red, font:huawenkaiti)[
        #h(0.1em)（用蓝、黑钢笔手写或小4号宋体字编辑，签名必须手写。可加页，A4纸双面打印）
        ]
      ]
    ]

    v(0.5em)

    align(right + bottom)[
    #text(size: 10.5pt)[
      指导教师（签名）：#h(7em)]\ 
      年#h(2em)月#h(2em)日#h(2em)
    ]

    v(1em)
  }

  let tb3()={
    text(weight: "bold", size: 10.5pt)[
      教研室（系、所）或开题报告答辩小组审核意见
      ]
  }

  let tb4()={
    align(right + bottom)[
    #text(size: 10.5pt)[
      教研室（系、所）或开题报告答辩小组负责人（签名）：#h(7em)]\ 
      年#h(2em)月#h(2em)日#h(2em)
    ]

    v(1em)
  }

  align(center)[
    #text(size: 16pt, weight: "bold")[华中科技大学本科毕业设计（论文）开题报告评审表]

    #tablex(
      columns: (4em, 1fr, 4em, 1.5fr, 6em, 1.2fr),
      rows: (3em, 3em, 8em, 27em, 2em, 12em),
      align: horizon + center,
      //content
      [*姓名*], [], [*学号*], [], [*指导教师*], [],
      colspanx(2)[*院（系）专业*], (), colspanx(4)[], (), (), (),
      colspanx(6)[#tb1()], (), (), (), (), (),
      colspanx(6)[#tb2()], (), (), (), (), (),
      colspanx(6)[#tb3()], (), (), (), (), (),
      colspanx(6)[#tb4()], (), (), (), (), (),
    )
  ]
}