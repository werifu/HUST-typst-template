// 默认本科生毕业论文的页面设置 (CSE 格式)
#import "../fonts/font-def.typ": *

// 页面大小
#let _set_paper_page_size(body) = {
    set page(paper: "a4", margin: (
        top: 2.5cm,
        bottom: 2.5cm,
        left: 3cm,
        right: 3cm
    ))

    body
}

// 页面布局
#let _set_paper_page_par(body) = {
    set text(font: songti, 12pt)
    set par(justify: true, leading: 1.24em, first-line-indent: 2em)
    show par: set block(spacing: 1.24em)

    body
}

// 页眉
#let _set_paper_page_header(anonymous: false, body) = {
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

    body
}

// 摘要部分页脚
#let _set_paper_page_footer_pre(body) = {
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

    body
}

// 正文部分页脚
#let _set_paper_page_footer_main(body) = {
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

    body
}