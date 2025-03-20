#import "/fonts/font-def.typ": *
#import "../utilities/indent-funs.typ": *
#import "@preview/i-figured:0.2.4"

#let appendix(body) = {
  // 这个取消目录里的 numbering
  set heading(level: 1, numbering: none)
  show <_appendix>: {
    // 这个取消展示时的 numbering
    set heading(level: 1, numbering: none)
    set align(center)
    set text(weight: "bold", font: heiti, size: 18pt)

    "附录"
  } + empty_par()

  
  [= 附录 <_appendix>]

  body
}