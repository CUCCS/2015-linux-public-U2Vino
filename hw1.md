# HW-1 无人值守Linux安装镜像制作

## 实验名称

* 无人值守安装ISO制作

## 实现特性

* 定制一个普通用户名和默认密码

* 定制安装OpenSSH Server

* 安装过程禁止自动联网更新软件包

## 实验过程

* 1.使用putty 连接目标主机

* 2.使用psftp将待重打包iso文件传进目标主机

![](https://raw.githubusercontent.com/CUCCS/2015-linux-public-U2Vino/HW-1/images%20of%20HW-1/putiso.PNG)

* 3.根据实验指导，输入命令如下

```
# 在当前用户目录下创建一个用于挂载iso镜像文件的目录
  mkdir cuc

  # 挂载iso镜像文件到该目录
  mount -o loop ubuntu.iso loopdir

  # 创建一个工作目录用于克隆光盘内容
  mkdir cd

  # 同步光盘内容到目标工作目录
  # 一定要注意loopdir后的这个/，cd后面不能有/
  rsync -av loopdir/ cd

  # 卸载iso镜像
  umount loopdir

  # 进入目标工作目录
  cd cd/
  ```

* 4.下图表明已成功将iso文件中内容同步到工作目录

![](https://raw.githubusercontent.com/CUCCS/2015-linux-public-U2Vino/HW-1/images%20of%20HW-1/1.PNG)

```
# 编辑Ubuntu安装引导界面增加一个新菜单项入口
 vim isolinux/txt.cfg
 # 添加以下内容到该文件后强制保存退出
 	label autoinstall
 	  menu label ^Auto Install Ubuntu Server
 	  kernel /install/vmlinuz
 	  append  file=/cdrom/preseed/ubuntu-server-autoinstall.seed debian-installer/locale=en_US console-setup/layoutcode=us keyboard-configuration/layoutcode=us console-setup/ask_detect=false localechooser/translation/warn-light=true localechooser/translation/warn-severe=true initrd=/install/initrd.gz root=/dev/ram rw quiet
```

![](https://raw.githubusercontent.com/CUCCS/2015-linux-public-U2Vino/HW-1/images%20of%20HW-1/conf.PNG)

* 5.将定制好的ubuntu-server-autoinstall.seed文件保存到刚才创建的工作目录~/cd/preseed/ubuntu-server-autoinstall.seed

* 6.生成iso文件

```
# 重新生成md5sum.txt
  	cd ~/cd && find . -type f -print0 | xargs -0 md5sum > md5sum.txt

  	# 封闭改动后的目录到.iso
  	IMAGE=custom.iso
  	# 路径要写成绝对路径，不然会出错
  	BUILD=/home/cuc/cd/

  	mkisofs -r -V "Custom Ubuntu Install CD" \
  	            -cache-inodes \
  	            -J -l -b isolinux/isolinux.bin \
  	            -c isolinux/boot.cat -no-emul-boot \
  	            -boot-load-size 4 -boot-info-table \
  	            -o $IMAGE $BUILD
```

![](https://raw.githubusercontent.com/CUCCS/2015-linux-public-U2Vino/HW-1/images%20of%20HW-1/md5sum.PNG)

* 7.安装mkisofs，运行脚本

![](https://raw.githubusercontent.com/CUCCS/2015-linux-public-U2Vino/HW-1/images%20of%20HW-1/bash.PNG)

* 8.生成好.iso，然后在psftp中用get拷贝出来

![](https://raw.githubusercontent.com/CUCCS/2015-linux-public-U2Vino/HW-1/images%20of%20HW-1/getiso.PNG)

## 问题

1.启用host-only网卡后，服务器没有获得IP地址

* 解决方法：修改配置文件

2.创建文件时，没有权限

* 解决方法：使用强制保存
