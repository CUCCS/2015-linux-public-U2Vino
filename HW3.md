# HW 3-Systemd 入门

## 命令篇

#### 1.系统管理

* [systemd-analyze](https://asciinema.org/a/ooAj3ZycUwfux4WWZqxn9IbN8)

* [hostnamectl](https://asciinema.org/a/0q90gViGq34SaWyKxGDMfZMry)

* [localectl](https://asciinema.org/a/dCmuYHumzCRcwZxSh2JMEs54Q)

* [timedatectl](https://asciinema.org/a/tcFHIuylHYOxuGXe1MoJHlwNF)

* [loginctl](https://asciinema.org/a/0eeKctMw5VHmUWqP9gX47lc3f)

#### 2.Unit

* [查看Unit](https://asciinema.org/a/8cJvkLLwcNKtQ12E8ny6x2zQu)

* [Unit状态](https://asciinema.org/a/WwokZwy3yskAWJdqpMW6Z1RDR)


* [Unit管理](https://asciinema.org/a/JIjIT57ZCqUpHhp7uLncbMws5)

* [依赖关系](https://asciinema.org/a/LIMF2iixyBw7JdbsDiEhfq94p)

#### 3.[Unit配置文件](https://asciinema.org/a/Fk3dVhUSaV5yNNFwx5oVdToEf)

#### 4.[Target](https://asciinema.org/a/0X3f6Uwdj84J3l2xIzugPHLrw)

#### 5.[journalctl](https://asciinema.org/a/EVuWNmneaFhQva37hVDBBo5Ur)

## [实战篇](https://asciinema.org/a/77d9ExKG2X6Mqemq5Y3Dj5g6V)

## 自查清单

#### 1.如何添加一个用户并使其具备sudo执行程序的权限？

```

* adduser [username]

* usermod -a -G [group] [username]

* 修改/etc/sudoers文件，添加username ALL=(ALL:ALL) ALL

```

#### 2.如何将一个用户添加到一个用户组？

* sudo usermod -a -G sudo [username]

#### 3.如何查看当前系统的分区表和文件系统详细信息？

* sudo fdisk -l

#### 4.如何实现开机自动挂载Virtualbox的共享目录分区？

* 在虚拟机管理中设置共享文件夹路径和分配方式

* 在sudo gedit /etc/fstab文件末添加一项： <共享名称> <共享目录> vboxsf defaults 0 0

#### 5.基于LVM（逻辑分卷管理）的分区如何实现动态扩容和缩减容量？


* LVM扩容

```

umount  /mnt/  
mkfs.ext4  /dev/vg1/lv1  
lvextend  -L 400M  /dev/vg1/lv1  
resize2fs  /dev/vg1/lv1

```

* LVM缩减

```

umount  /mnt/
e2fsck -f /dev/vg1/lv1  
resize2fs  /dev/vg1/lv1  200M  
mount  /dev/vg1/lv1   /mnt/  

```

#### 6.如何通过systemd设置实现在网络连通时运行一个指定脚本，在网络断开时运行另一个脚本？

* 更改该网络服务的配置文件

* 网通连通时运行指定脚本

```

[Service]  
...  
ExecStart: path-of-script -D $OPTIONS  
...

```

* 网络断开时运行另一个脚本

```

[Service]  

...  
ExecStop: path-of-script -D $OPTIONS  
...

```

#### 7.如何通过systemd设置实现一个脚本在任何情况下被杀死之后会立即重新启动？实现杀不死？

* 设置该脚本配置文件

```

[Service]  
...  
Restart:always  
...

```
