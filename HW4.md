# HW-4 shell脚本编程

## 任务一（图片批处理）

* [code](https://github.com/CUCCS/2015-linux-public-U2Vino/blob/HW-4/Code/task1.sh)

* 支持命令行参数方式使用不同功能

>bash task1.sh -h

![](https://raw.githubusercontent.com/CUCCS/2015-linux-public-U2Vino/HW-4/ScreenShots/1.PNG)

* 对jpeg格式图片进行图片质量压缩

> bash task1.sh -d PicTest/ -j 45

![](https://raw.githubusercontent.com/CUCCS/2015-linux-public-U2Vino/HW-4/ScreenShots/2.PNG)

* 对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率

> bash task1.sh -d PicTest/ -c 100

![](https://raw.githubusercontent.com/CUCCS/2015-linux-public-U2Vino/HW-4/ScreenShots/3.PNG)

* 对图片批量添加自定义文本水印

> bash task1.sh -d PicTest/ -e "hahaha"

![](https://raw.githubusercontent.com/CUCCS/2015-linux-public-U2Vino/HW-4/ScreenShots/4.PNG)

* 批量重命名（统一添加文件名前缀或后缀，不影响原始文件扩展名）

> bash task1.sh -d PicTest/ -p "pre"

> bash task1.sh -d PicTest/ -S "suffix"

![](https://raw.githubusercontent.com/CUCCS/2015-linux-public-U2Vino/HW-4/ScreenShots/5.PNG)

* 将png/svg图片统一转换为jpg格式图片

> bash task1.sh -d PicTest/ -v

![](https://raw.githubusercontent.com/CUCCS/2015-linux-public-U2Vino/HW-4/ScreenShots/6.PNG)

## 任务二

* [code](https://github.com/CUCCS/2015-linux-public-U2Vino/blob/HW-4/Code/task2.sh)

* 统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比；年龄最大的球员是谁？年龄最小的球员是谁？

![](https://raw.githubusercontent.com/CUCCS/2015-linux-public-U2Vino/HW-4/ScreenShots/7.PNG)

* 统计不同场上位置的球员数量、百分比

![](https://raw.githubusercontent.com/CUCCS/2015-linux-public-U2Vino/HW-4/ScreenShots/8.PNG)

* 名字最长的球员是谁？名字最短的球员是谁

![](https://raw.githubusercontent.com/CUCCS/2015-linux-public-U2Vino/HW-4/ScreenShots/9.PNG)

## 任务三（Web服务器）
* 便于测试，只打印输出10行

* [code](https://github.com/CUCCS/2015-linux-public-U2Vino/blob/HW-4/Code/task3.sh)

* --help帮助文档

> bash task3.sh --help

![](https://raw.githubusercontent.com/CUCCS/2015-linux-public-U2Vino/HW-4/ScreenShots/10.PNG)

* 统计访问来源主机TOP 100和分别对应出现的总次数

> bash task3.sh -d ./web_log.tsv -h 10

[数据](https://github.com/CUCCS/2015-linux-public-U2Vino/blob/HW-4/data/1.txt)

![](https://raw.githubusercontent.com/CUCCS/2015-linux-public-U2Vino/HW-4/ScreenShots/11.PNG)

* 统计访问来源主机TOP 100 IP和分别对应出现的总次数

> bash task3.sh -d ./web_log.tsv -i 10

[数据](https://github.com/CUCCS/2015-linux-public-U2Vino/blob/HW-4/data/2.txt)

![](https://raw.githubusercontent.com/CUCCS/2015-linux-public-U2Vino/HW-4/ScreenShots/12.PNG)

* 统计最频繁被访问的URL TOP 100

> bash task3.sh -d ./web_log.tsv -u 10

[数据](https://github.com/CUCCS/2015-linux-public-U2Vino/blob/HW-4/data/3.txt)

![](https://raw.githubusercontent.com/CUCCS/2015-linux-public-U2Vino/HW-4/ScreenShots/13.PNG)

* 统计不同响应状态码的出现次数和对应百分比

> bash task3.sh -d ./web_log.tsv -r

![](https://raw.githubusercontent.com/CUCCS/2015-linux-public-U2Vino/HW-4/ScreenShots/14.PNG)

* 分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数

> bash Task_3.sh -d ./web_log.tsv -x 10

![](https://raw.githubusercontent.com/CUCCS/2015-linux-public-U2Vino/HW-4/ScreenShots/15.PNG)

* 给定URL输出TOP 100访问来源主机

> bash Task_3.sh -d ./web_log.tsv -l "/images/launchmedium.gif"

[数据](https://github.com/CUCCS/2015-linux-public-U2Vino/blob/HW-4/data/4.txt)

![](https://raw.githubusercontent.com/CUCCS/2015-linux-public-U2Vino/HW-4/ScreenShots/16.PNG)
