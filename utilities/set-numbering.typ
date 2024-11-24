#import "@preview/i-figured:0.2.4"

// 设置编号 (引用时, 需要使用标签), 注意, 必须在 heading 设置完成后再调用
#let _set_numbering(body) ={
    show heading: i-figured.reset-counters
    show figure: i-figured.show-figure.with(numbering: "1-1")
    show math.equation: i-figured.show-equation.with(numbering: "(1-1)")

    body
}