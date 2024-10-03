// 参考文献
#let _set_references(csl_style: "pages/hust-cse-ug.csl", body) = {
    set bibliography(title: "参考文献", style: csl_style)

    show bibliography: it =>{
        set heading(level: 1, numbering: none)

        set par(justify: false, leading: 1.24em, first-line-indent: 2em)

        it
    }

    body
}

