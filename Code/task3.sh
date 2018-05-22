#!/bin/bash

function help
{
	echo "NAME"
	echo "	Task_3.sh - batch processing on web server access log"
	echo "SYNOPSIS"
	echo "	bash Task_3.sh [-d directory] [-h|-i|-u|-r|-x num] [-l url] [--help]"
	echo "DESCRIPTION"
	echo "	-d directory: type in the dir of the file that you want to operate"
	echo "	-h show the top num source hosts visited"
	echo "	-i show the top num source IP addresses visited"
	echo "	-u show the top num most frequently visited url"
	echo "	-r show the percentages of different response status codes"
	echo "	-x show the top num url and the times of occurance related to 4xx response"
	echo "	num: 100 in default"
	echo "	-l url: show the top num source hosts related to the url input"
	echo "	--help: to get the help manual"
	
}


function host
{
	# awk -F '\t'	行内分隔符为\t
	# sort -r (降序排列) -n(按数值排序) -k 2(按输出的第2列排序)
	
	sed -n '2,$p' "$1" \
        | awk -F '\t' ' {host[$1]++} END {for(h in host) printf("%-50s %-10d\n",h,host[h])}' \
	| sort -r -n -k 2| sed -n 1,"$2"p
}


function Ip
{
         sed -n '2,$p' "$1" \
         | awk -F '\t' '$1 ~ /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]/{ip[$1]++} END {for(i in ip) printf("%-15s%-10d\n",i,ip[i])}' \
         | sort -n -r -k 2 | sed -n 1,"$2"p

		# 注意：如下这样写的含义是：只要不全是由字母组成的主机名均可以，即出现一个非字母即可
		# | awk -F '\t' '$1 ~! /[a-zA-Z]/{ip[$1]++} END {for(i in ip) print(i,ip[i])}' \
}



function url
{
         sed -n '2,$p' "$1" \
         | awk -F '\t' '{url[$5]++} END {for(u in url) printf("%-50s%-10d\n",u,url[u])}' \
         | sort -r -n -k 2 | sed -n 1,"$2"p
}




function response
{
		# 所有行读完后，NR即为总数
         sed -n '2,$p' "$1" \
         | awk -F '\t' '{rsp[$6]++} END {for(r in rsp) printf("%-4s%-10d%-4.4f%%\n",r,rsp[r],rsp[r]/NR*100)}' \
         | sort -r -n -k 2 | sed -n '1,$p'
} 



function Resp4xx
{      
		# 先找出所有以4开头的响应码，暂存在code中
         code=$(sed -n '2,$p' "$1" | awk -F '\t' '{if($6~/^4/) {print $6} }' | sort -u) 
		
		# 对每一个状态码，都要重新遍历整个文件，效率较低
         for c in $code; do
                 echo "$c"
                 sed -n '2,$p' "$1" | awk -F '\t' '{if($6=="'$c'") {cnt[$5]++}} END {for(t in cnt)printf("%-50s%-10d\n",t,cnt[t])}' | sort  -r -n -k 2 | sed -n 1,"$2"p
                 echo " "
         done
 
		# 如下这样写，会对所有状态码对应的url次数整体排序，无法达到“分别”取top前10的效果
		#| awk -F '\t' '$6~/^4/{rsp4[$6":"$5]++} END {for(k in rsp4) printf("%-4s%-60s\n",k,rsp[k])}' \
        # 使用二维数组也无法达到“分别排序”的目的
        #| awk -F '\t' '$6~/^4/{rsp4[$6,$5]++} END {for(k in rsp4) { split(k,index,SUBSEP); printf("%-4s%-50s%-10s\n",index[1],index[2],      rsp4[k]) }}' \
}



function urlHost
{
         sed -n '2,$p' "$1"| \
         awk -F '\t' '{if($5=="'$2'") a[$1]++} END {for(h in a) printf("%-30s%-10d\n",h,a[h])}' \
         | sort -r -n -k 2 | sed -n '1,100p'  
}



############## Main ###############

dir=""
num=100

if [[ $# -eq 0 ]]; then
	echo "What operations do you want? Type in please"
else
	while [[ $# -ne 0 ]]; do
	# echo "$dir"
		if [[ "$1" == "-d" ]];then				# 输入文件路径 
			dir="$2" 
			shift 2								# shift换行写，否则会出现逻辑错误
		elif [[ "$1" == "--help" ]]; then		# 请求帮助文档 
			help 
			shift	
		elif [[ "$1" == "-l" ]]; then 			# 输入url
			shift
			if [[ "$1" == "" ]]; then 
				echo "You need to input a url"
			else 
				if [[ $dir != "" ]]; then 
					urlHost "$dir" "$1" 
				else 
					echo "You need to input a file"
				fi
				shift
			fi
		else 
			if [[ "$2" != "" ]]; then num=$2 	 	# [-h|-i|-u|-r|-x num]
			# else shift  # 默认num为100
			fi
			if [[ $dir != '' ]]; then
				case "$1" in 
					'-h') host "$dir" "$num" 
						shift 2
						;;
					'-i') Ip "$dir" "$num"
						shift 2
						;;
					'-u') url "$dir" "$num"
						shift 2
						;;
					'-r') response "$dir"
						shift
						;;
					'-x') Resp4xx "$dir" "$num"
						shift 2
						;;
				esac
				#shift 2
			else 
				echo "You need to input a file"  
				shift 2
			fi
		fi
	done
fi