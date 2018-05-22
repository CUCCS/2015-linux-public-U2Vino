#!/bin/bash

function AgeInfo
{
	MIN=100					# 记录最小年龄
	youngest=()				# 记录年龄最小的人的名字（不止一个）
	MAX=0					# 记录最大年龄
	oldest=()				# 记录年龄最大的人的名字（不止一个）
	less_than_20=0 			# 计数年龄小于20岁的人数
	between_20_30=0			# 计数年龄为[20,30]岁的人数
	greater_than_30=0		# 计数年龄大于30岁的人数
	
	## 确定Age列和name列的列号
	line=$(head -1 "$1")
	IFS="	" read -r -a arr <<< "$line"
	i=0
	for w in "${arr[@]}"; do
		if [[ "$w" == "Age" ]]; then 
			index_age="$i" 
		fi
		if [[ "$w" == 'Player' ]]; then
			index_name="$i"
		fi
		i=$((i+1))
	done
	
	# 从第二行开始往下读
	sum=0
	ln=2
	line="$(sed -n "$ln"p "$1")"
	while [[ "$line" != "" ]]; do
		sum=$((sum+1))
		IFS="	" read -r -a arr <<< "$line"
		age=${arr["$index_age"]}
		name=${arr["$index_name"]}
		
		if [[ "$age" -lt 20 ]]; then
			less_than_20=$((less_than_20+1))
		elif [[ "$age" -gt 30 ]]; then
			greater_than_30=$((greater_than_30+1))
		else
			between_20_30=$((between_20_30+1))
		fi
		
		if [[ $age -lt $MIN ]]; then MIN="$age" youngest=("$name") 		# 若小于，则更新最小年龄，重构数组
		elif [[ $age -eq $MIN ]]; then youngest=("${youngest[@]}" "$name")	# 若等于，则直接添加进数组
		fi

		if [[ $age -gt $MAX ]]; then 
			MAX="$age" 
			oldest=("$name")
		elif [[ $age -eq $MAX ]]; then 
			oldest=("${oldest[@]}" "$name")
		fi	

		ln=$((ln+1))
		line="$(sed -n "$ln"p "$1")"
	done

	# 使用bc进行浮点数运算，保留小数点后4位
	# p1=$(echo "scale=4; $less_than_20/$sum*100" | bc)	
	# p2=$(echo "scale=4; $between_20_30/$sum*100" | bc)
	# p3=$(echo "scale=4; $greater_than_30/$sum*100" | bc)	
	

	echo "The oldest player: "
	for p in "${oldest[@]}"; do echo "$p"; done
	echo "They are $MAX years old"
	echo -e "\n"	

	echo "The youngest player: "
	for p in "${youngest[@]}"; do echo "$p"; done
	echo "They are $MIN years old" 
	echo -e "\n"	

	echo "There are $less_than_20 players younger than 20, taking up $(printf "%.4f" $(echo "$less_than_20/$sum*100" | bc -l))% of all players"
	echo "There are $between_20_30 players aged between 20 and 30, taking up $(printf "%.4f" $(echo "$between_20_30/$sum*100" | bc -l))% of all players"
	echo "There are $greater_than_30 players older than 30, taking up $(printf "%.4f" $(echo "$greater_than_30/$sum*100" | bc -l))% of all players"
}


function PosInfo
{
	# 确定Position的列号
	line=$(head -1 "$1")
	IFS='	' read -r -a arr <<< "$line"
	i=0
	for w in "${arr[@]}"; do
		if [[ "$w" == "Position" ]]; then 
			break
		fi
		i=$((i+1))
	done
	
	declare -A dic		## 定义字典，<球场位置，数量>
	#dic=()
	sum=0

	# 从第2行开始读
	ln=2
	line="$(sed -n "$ln"p "$1")"
	while [[ "$line" != "" ]]; do
		sum=$((sum+1))
		IFS='	' read -r -a arr <<< "$line"
		pos=${arr["$i"]}
		mark=0
		for key in "${!dic[@]}"; do			# 判断字典中是否有键与$pos相同
			if [[ "$pos" == "$key" ]]; then 
				dic[$key]=$(( ${dic[$key]}+1 ))
				mark=1
				break
			fi
		done
		if [[ "$mark" -ne 1 ]]; then
			value=1 
			dic[$pos]=$value
		fi

		ln=$((ln+1))
		line="$(sed -n "$ln"p "$1")"
	done
	
	printf "+--------------------------------+\n"
	printf "| Position |  Amount  |  Rate(%%) |\n"
	printf "+--------------------------------+\n"
	for pos in "${!dic[@]}"; do 
		# r=$(echo "scale=4; ${dic[$pos]}/$sum*100" | bc)
		printf "|%-10s|%-10s|" "$pos" "${dic[$pos]}"
		printf "%-10.2f|\n" $(echo "${dic[$pos]}/$sum*100" | bc -l)
		printf "+--------------------------------+\n" 
	done
	
}


function NameInfo
{
	shortest=100
	sn=()
	longest=0
	ln=()
	
	# 确定Player的列号
	line=$(head -1 "$1")
	IFS='	' read -r -a arr <<< "$line"
	i=0
	for w in "${arr[@]}"; do
		if [[ "$w" == "Player" ]]; then
			break
		fi
		i=$((i+1))
	done
	
	l=2
	line=$(sed -n "$l"p "$1")
	while [[ "$line" != "" ]]; do
		IFS='	' read -r -a arr <<< "$line"
		name=${arr[$i]}
		
		length=0
		IFS=' ' read -r -a namarr <<< "$name"
		for w in "${namarr[@]}"; do length=$((length+${#w}));done

		# 出现更小的长度
		if [[ $length -lt $shortest ]]; then 
			shortest=$length 
			sn=("$name")
		# 名字长度相等
		elif [[ $length -eq $shortest ]]; then
			mark=0
			for n in "${sn[@]}"; do 	# 去重
				if [[ $n == "$name" ]]; then mark=1 break; fi
			done
			if [[ $mark -eq 0 ]]; then sn=(${sn[@]} "$name"); fi
		fi
		
		# 出现更长的长度
		if [[ $length -gt $longest ]]; then 
			longest=$length 
			ln=("$name");
		# 名字长度相等
		elif [[ $length -eq $longest ]]; then
			mark=0
			for n in "${ln[@]}"; do
				if [[ $n == "$name" ]]; then mark=1 break; fi
			done
			# if [[ $mark -eq 0 ]]; then ln=(${ln[@]} "$name"); fi
			if [[ $mark -eq 0 ]]; then ln[${#ln[@]}+1]="$name"; fi
		fi
		
		l=$((l+1))
		line=$(sed -n "$l"p "$1")
	done
	
	for p in "${ln[@]}"; do echo "$p"; done
	printf "have the longest name ,length %s\n\n" "$longest"
	for p in "${sn[@]}"; do echo "$p"; done
	printf "have the shortest name ,length %s\n" "$shortest" 
	
}


AgeInfo "worldcupplayerinfo.tsv"
PosInfo "worldcupplayerinfo.tsv"
NameInfo "worldcupplayerinfo.tsv"