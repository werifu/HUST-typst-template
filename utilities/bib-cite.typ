// 引用文献相关函数
#let bib_cite(..names) = {
  for name in names.pos() {
    cite(name)
  }
}