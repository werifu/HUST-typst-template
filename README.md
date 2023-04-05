# HUST-typst-template

用于华科毕业设计（本科）的 typst 模板。

## 什么是 typst

[typst](https://github.com/typst/typst) 是最新最热的标记文本语言，定位与 LaTeX 类似，具有极强的排版能力，通过一定的语法写文档，然后生成 pdf 文件。与 LaTeX 相比有以下的优势：

1. 编译巨快：因为提供增量编译的功能所以在修改后基本能在一秒内编译出 pdf 文件，typst 提供了监听修改自动编译的功能，可以像 Markdown 一样边写边看效果。
2. 环境搭建简单：原生支持中日韩等非拉丁语言，不用再大量折腾字符兼容问题以及下载好几个 G 的环境。只需要下载命令行程序就能开始编译生成 pdf。
3. 语法友好：对于普通的排版需求，上手难度跟 Markdown 相当，同时文本源码阅读性高：不会再充斥一堆反斜杠跟花括号

个人观点：跟 Markdown 一样好用，跟 LaTeX 一样强大

可以从[这里速通 typst](https://typst.app/docs/tutorial)

跟 word 比的优势：好用太多了

## 使用

快速浏览效果：[查看sample.pdf](./sample.pdf)，样例论文源码：[查看sample.typ](./sample.typ)

### 线上编辑

typst 也提供了线上编辑器（类似overleaf），查看本模板：
https://typst.app/project/rqTPs502DAhLTQctaUmbtn

（ps：浏览器可能没宋体，字体可能不对，请忽略字体）

### 本地编辑

1. 下载对应平台的 typst：https://github.com/typst/typst/releases 记得先看看它的 README
2. clone 本仓库
3. 按本仓库中的 sample.typ 照葫芦画瓢即可
4. 在本项目目录里，命令行执行类似 `/path/to/your/typst watch xxx.typ` 的命令即可编译同名 pdf 文件，而且一旦更新就会增量编译，推荐在 VSCode 中写，下载 `Typst LSP` 插件获得语法提示

## 说明

这个模板应该还不是完全版，可能不能覆盖到华科论文的所有case要求，如果遇到特殊 case 请提交 issue 说明，或者也可以直接提 pull request

同时，由于 typst 太新了，2023年4月初刚发布0.1.0版本，可能会有大的break change发生，模板会做相应修改。



