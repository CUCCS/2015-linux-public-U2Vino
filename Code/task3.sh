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
	# awk -F '\t'	���ڷָ���Ϊ\t
	# sort -r (��������) -n(����ֵ����) -k 2(������ĵ�2������)
	
	sed -n '2,$p' "$1" \
        | awk -F '\t' ' {host[$1]++} END {for(h in host) printf("%-50s %-10d\n",h,host[h])}' \
	| sort -r -n -k 2| sed -n 1,"$2"p
}


function Ip
{
         sed -n '2,$p' "$1" \
         | awk -F '\t' '$1 ~ /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]/{ip[$1]++} END {for(i in ip) printf("%-15s%-10d\n",i,ip[i])}' \
         | sort -n -r -k 2 | sed -n 1,"$2"p

		# ע�⣺��������д�ĺ����ǣ�ֻҪ��ȫ������ĸ��ɵ������������ԣ�������һ������ĸ����
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
		# �����ж����NR��Ϊ����
         sed -n '2,$p' "$1" \
         | awk -F '\t' '{rsp[$6]++} END {for(r in rsp) printf("%-4s%-10d%-4.4f%%\n",r,rsp[r],rsp[r]/NR*100)}' \
         | sort -r -n -k 2 | sed -n '1,$p'
} 



function Resp4xx
{      
		# ���ҳ�������4��ͷ����Ӧ�룬�ݴ���code��
         code=$(sed -n '2,$p' "$1" | awk -F '\t' '{if($6~/^4/) {print $6} }' | sort -u) 
		
		# ��ÿһ��״̬�룬��Ҫ���±��������ļ���Ч�ʽϵ�
         for c in $code; do
                 echo "$c"
                 sed -n '2,$p' "$1" | awk -F '\t' '{if($6=="'$c'") {cnt[$5]++}} END {for(t in cnt)printf("%-50s%-10d\n",t,cnt[t])}' | sort  -r -n -k 2 | sed -n 1,"$2"p
                 echo " "
         done
 
		# ��������д���������״̬���Ӧ��url�������������޷��ﵽ���ֱ�ȡtopǰ10��Ч��
		#| awk -F '\t' '$6~/^4/{rsp4[$6":"$5]++} END {for(k in rsp4) printf("%-4s%-60s\n",k,rsp[k])}' \
        # ʹ�ö�ά����Ҳ�޷��ﵽ���ֱ����򡱵�Ŀ��
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
		if [[ "$1" == "-d" ]];then				# �����ļ�·�� 
			dir="$2" 
			shift 2								# shift����д�����������߼�����
		elif [[ "$1" == "--help" ]]; then		# ��������ĵ� 
			help 
			shift	
		elif [[ "$1" == "-l" ]]; then 			# ����url
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
			# else shift  # Ĭ��numΪ100
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