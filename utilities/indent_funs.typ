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