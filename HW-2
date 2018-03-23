# HW-2 VimTutor

## 实验视频

* [Lesson 1](https://asciinema.org/a/oEcMUDAyVWcDgTPvsaY24BoU7)

* [Lesson 2](https://asciinema.org/a/JyM2QYCtwgpWmzLBahr0sPhB9)

* [Lesson 3](https://asciinema.org/a/61Zc3vQpA06p6LHPWWp7o8CHR)

* [Lesson 4](https://asciinema.org/a/nWJEWsNlAe8z0z72IJ6X3kAV5)

* [Lesson 5](https://asciinema.org/a/CNSqdSo01BEdcE2069QAFwjaL)

* [Lesson 6](https://asciinema.org/a/uVHQyo1bf3VnhiWLAyjFCLHMA)

* [Lesson 7](https://asciinema.org/a/5uCjDwoWOcaVIrrtkZMXy2wbL)

* [语法高亮](https://asciinema.org/a/XPfbRM77tz1eQngIwmLVl4T6q)

## 自查清单

* 你了解vim有哪几种工作模式？

> 正常模式： 后进入的模式

>插入模式： ----insert----

>选择模式：-----visual----

>命令模式：在编辑状态下左下角可以输入命令

* Normal模式下，从当前行开始，一次向下移动光标10行的操作方法？如何快速移动到文件开始行和结束行？如何快速跳转到文件中的第N行？

>大写的G代表shift+g，小写代表直接按g

>跳十行：10j

>开始: gg 0G

>结束: G

>第N行： NG

* Normal模式下，如何删除单个字符、单个单词、从当前光标位置一直删除到行尾、单行、当前行开始向下数N行？

>单个字符： x

>单个单词： dw

>删到行尾： d$

>删除单行：dd

>删除向下N行： Ndd，dNd

* 如何在vim中快速插入N个空行？如何在vim中快速输入80个-？

>N个空行：100o

>80个-：80i-

* 如何撤销最近一次编辑操作？如何重做最近一次被撤销的操作？

>u

>U

* vim中如何实现剪切粘贴单个字符？单个单词？单行？如何实现相似的复制粘贴操作呢？

>剪切粘贴：

>>字符：d p

>>单词：dw p

>>单行：dd p

>复制粘贴：

>>复制：按v，进入visual模式，用hjkl选中要复制内容，或用$到行尾，w到单词尾部，按y复制

>>粘贴：p

* 为了编辑一段文本你能想到哪几种操作方式（按键序列）？

>命令行输入vim filename，然后i/o/a/c等键进入编辑模式，或是用剪切/复制/粘贴命令，编辑完成后，:wq保存退出

>用:edit filename命令

* 查看当前正在编辑的文件名的方法？查看当前光标所在行的行号的方法？

>Ctrl+g

* 在文件中进行关键词搜索你会哪些方法？如何设置忽略大小写的情况下进行匹配搜索？如何将匹配的搜索结果进行高亮显示？如何对匹配到的关键词进行批量替换？

>向前搜索(keyword为要搜索的关键词)：/keyword

>向后搜索： ？keyword

>忽略大小写： :ser ic

>设置高亮： :set hls is

>批量替换： :s/old/new/g

* 在文件中最近编辑过的位置来回快速跳转的方法？

>Ctrl + i / Ctrl + o


* 如何把光标定位到各种括号的匹配项？例如：找到(, [, or {对应匹配的),], or }

>%

* 在不退出vim的情况下执行一个外部程序的方法？

>:!+命令

* 如何使用vim的内置帮助系统来查询一个内置默认快捷键的使用方法？如何在两个不同的分屏窗口中移动光标？

>:help后加想要查的命令，例如： :help g/w

>Ctrl + w

## 问题

* 使用apt直接安装的asciicast版本太低不能上传

>解决办法：使用官方文档中提供的方法，安装最新版本

>>sudo apt-add-repository ppa:zanchey/asciinema

>>sudo apt update

>>sudo apt install asciinema
