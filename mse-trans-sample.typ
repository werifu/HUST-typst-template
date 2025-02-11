// #import "cs-template.typ": *
#import "mse-trans-template.typ": *
#import "@preview/codelst:2.0.0": sourcecode
#show: setup-lovelace

#let algorithm = algorithm.with(supplement: "算法")

#show: project.with(
  anonymous: false,
  title: "WEN B, YANG W, KAUTZ J, et al. FoundationPose: Unified 6D Pose Estimation and Tracking of Novel Objects. 2024 IEEE/CVF Conference on Computer Vision and Pattern Recognition (CVPR): Vol. 02024: 17868~17879",
  title_trans: [FoundationPose：统一的任意物体六自由度姿态估计与跟踪方法],
  abstract_zh: [
  先帝创业未半而中道崩殂，今天下三分，益州疲弊，此诚危急存亡之秋也。然侍卫之臣不懈于内，忠志之士忘身于外者，盖追先帝之殊遇，欲报之于陛下也。诚宜开张圣听，以光先帝遗德，恢弘志士之气，不宜妄自菲薄，引喻失义，以塞忠谏之路也。

  宫中府中，俱为一体；陟罚臧否，不宜异同。若有作奸犯科及为忠善者，宜付有司论其刑赏，以昭陛下平明之理，不宜偏私，使内外异法也。
  ],
  keywords_zh: ("关键词1", "关键词2", "关键词3"),
  author: "作者",
  school: "复制粘贴写报告学院",
  id: "U000114514",
  mentor: "你的老板",
  class: "XXXX 专业 0000 班",
  date: (1926, 8, 17)
)

= 模板使用注意

本模板参考自 2024 年机械学院本科生毕设参考文献译文本模板，基本使用方法与本科生毕设模板相同，主要使用注意如下：

- 翻译文本如果不需要摘要，可在模板函数内删除
- 参考文献原文可在导出 pdf 后手动通过 Acrobat 等软件将原文合并到末尾。
- 译文要求的内容可手动修改函数 `mse_trans_declaration`

= 占位章节
== XXXX

#lorem(30)#cite(<刘星2014恶意代码的函数调用图相似性分析>)

== YYYY

#lorem(10)#cite(<papadimitriou1998combinatorial>)

#pagebreak()

#bibliography("./ref.bib")
