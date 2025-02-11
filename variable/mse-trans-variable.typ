// TODO: 参考文献样式与实例文件

#import "../fonts/font-def.typ": *

#let mse_trans_paper_cover(cover_logo_path: "../assets/cs-hust.png", anonymous, title, school, class, author, id, mentor, date) = {
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
    )[本科毕业设计（论文）参考文献译文本]

    #v(40pt)

    #text(
      font: zhongsong,
      size: 15pt,
    )[
      译文出处：
    ] #text(
      font: zhongsong,
      size: 14pt,
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

// 译文要求
#let mse_trans_declaration() = {
  
  set par(justify: true, leading: 16pt)

  text(
    font: zhongsong,
    size: 16pt,
    weight: "bold"
  )[
    译文要求
  ]
  
  text(
    font: zhongsong,
    size: 14pt,
  )[
    #set enum(numbering: "一、 ")
    + 译文内容须与课题（或专业内容）联系，并需在封面注明详细出处。
    + 出处格式为\ 
      图书：作者.书名.版本（第×版）.译者.出版地：出版者，出版年.起页～止页\ 
      期刊：作者.文章名称.期刊名称，年号，卷号（期号）：起页～止页
    + 译文不少于5000汉字（或2万印刷符）。
    + 翻译内容用五号宋体字编辑，采用A4号纸双面打印，封面与封底采用浅蓝色封面纸（卡纸）打印。要求内容明确，语句通顺。
    + 译文及其相应参考文献一起装订，顺序依次为封面、译文、参考文献原文。
    + 翻译应在第七学期完成。
  ]

  v(0em)

  box(stroke: (bottom: 0.5pt), inset: 5pt)[
    #h(1fr)
    #text(
      font: zhongsong,
      size: 16pt,
      weight: "bold",
    )[
      译文评阅
    ]    
    #h(1fr)
  ]

  text(
    font: songti,
    size: 14pt,
    weight: "bold"
  )[
    导师评语  #parbreak()
  ]

  text(
    font: songti,
    size: 14pt,
  )[
    应根据学校“译文要求”，对学生译文翻译的准确性、翻译数量以及译文的文字表述情况等做具体的评价后，再评分。
  ]

  v(80pt)

  text(
    font: songti,
    size: 12pt,
  )[
    评分：#box(stroke: (bottom: 0.5pt), inset: 5pt)[#h(5em)]（百分制）#h(1fr)指导教师（签名）：#box(stroke: (bottom: 0.5pt), inset: 5pt)[#h(5em)]
  ]

  v(1em)

  text(
    font: songti,
    size: 12pt,
  )[#h(1fr) 年#h(2em)月#h(2em)日]

}

#let _mse_trans_set_heading(body) ={
    set heading(numbering: "1.1.1.1.")
    set heading(supplement: [节])

    // 参考自 https://github.com/nju-lug/modern-nju-thesis/blob/main/utils/custom-heading.typ
    show heading: it =>{
        if it != none {
        set par(first-line-indent: 0em)
        if it.has("numbering") and it.numbering != none {
        numbering(it.numbering, ..counter(heading).at(it.location()))
        [　 ]
        }
        it.body
    } else {
        ""
    }
    }
    show heading.where(level: 1): it => {
        // set align(center)
        set text(weight: "bold", font: songti, size: 10.5pt)
        set block(spacing: 1.5em)
        it
    }
    show heading.where(level: 2): it => {
        set text(weight: "bold", font: songti, size: 10.5pt)
        set block(above: 1.5em, below: 1.5em)
        it
    }
    show heading.where(level: 3): it => {
        set text(weight: "bold", font: songti, size: 10.5pt)
        set block(above: 1.5em, below: 1.5em)
        it
    }
    show heading.where(level: 4): it => {
        set text(weight: "bold", font: songti, size: 10.5pt)
        set block(above: 1.5em, below: 1.5em)
        it
    }

    body
}

// 页眉
#let _mse_trans_set_paper_page_header(anonymous: false, body) = {
    set page(
        header: {
        set text(font: songti, 10pt, baseline: 8pt, spacing: 3pt)
        set align(center)
        if not anonymous {
            [华中科技大学本科毕业设计（论文）参考文献译文]
        } else {
            [█████████████████████████]
        }

        v(1em)
        
        line(length: 100%, stroke: 0.7pt)
        }
    )

    body
}

// 页面布局
#let _mse_trans_set_paper_page_par(body) = {
    set text(font: songti, 10.5pt)
    set par(justify: true, leading: 1.5em, first-line-indent: 2em)
    //set par(spacing: 1.5em)

    body
}

// 设置图表
#let _mse_trans_set_figure(body) ={
    // 设置前缀
    show figure.where(kind: image): set figure(supplement: [图])

    show figure.where(kind: table): set figure(supplement: [表])
    show figure.where(kind: table): set figure.caption(position: top)

    // 使用正确的编号与图表标题字体及分隔符
    show figure.caption: set text(font: songti)
    set figure.caption(separator: "　")

    set math.equation(supplement: [公式])

    body
}

// 引入参考文献原文
#let orgin_intro() ={
  pagebreak()

  set page(footer: none, header: none)

  v(7em)
  text(weight: "bold", font: zhongsong, size: 16pt)[
    #h(1fr) 参考文献原文 #h(1fr) 
  ]
}

// 参考文献摘要
#let mse_trans_abstract(abstract, keywords: ()) ={

  set heading(level: 1, numbering: none)
  show <_zh_abstract_>: {
    align(center)[
      #text(font: heiti, size: 10.5pt, "摘　　要")
    ]
  }
  [= 摘要 <_zh_abstract_>]

  set text(font: songti, size: 10.5pt)

  abstract
  par(first-line-indent: 0em)[
    #text(weight: "bold", font: heiti, size: 10.5pt)[
      关键词：
      #keywords.join("；")
    ]
  ]

}
