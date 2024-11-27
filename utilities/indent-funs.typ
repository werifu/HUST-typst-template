// 缩进相关函数
#let indent() = {
  box(width: 2em)
}

#let indent_par(body) = {
  box(width: 1.8em)
  body
}

#let empty_par() = {
  v(-1em)
  box()
}

#let _fix_indent(body) = {
  // 首段不缩进，手动加上 box
  show heading: it => {
    it + empty_par()
  }
  show figure: it => {
    it + empty_par()
  }
  show math.equation.where(block: true): it => {
    it + empty_par()
  }  

  body
}
