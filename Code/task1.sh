#!bin/bash

# --help 帮助文档
function Instructions {
	echo "Directions for use:	bash Task_1.sh [options]"
	echo "the options:"
	echo "-d	Type in the directory of pictures that you want to operate"
	echo "-j	Type in to specify a compression level for JPEG images"
	echo "-c	Type in a width to resize the image while preserving the aspect ratio"
	echo "-e	Type in the watermark that you want to embed in the pictures"
	echo "-p	Type in the prefix that you want to add to the names of the pictures"
	echo "-s	Type in the suffix that you want to add to the names of the pictures"
	echo "-v	To convert png/svg to jpeg files"
	echo "-h	Get the instructions of the script"
}

# 对jpeg格式图片进行图片质量压缩
function JPGCompress {                                                                                                                 
    	[ -d "out-j" ] || mkdir "out-j"
	for p in "$1"*.jpg; do
	        fullname="$(basename "$p")"
        	# filename=$(echo "$fullname" | cut -d . -f1)
		filename="${fullname%.*}"
        	convert "$p" -quality "$2"% ./out-j/"$filename"."jpg"
	done

	#find "$1" -type f -name '*.jpg' -exec convert {} -quality "$2" "./out_j/$(${p%.*}).jpg" \;
}

# 对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
function CompressResolution {
	[ -d "c-output" ] || mkdir c-output
	for p in $(find "$1" -regex  '.*\.jpg\|.*\.svg\|.*\.png'); do
		fullname="$(basename "$p")"
		# filename=$(echo "$fullname" | cut -d . -f1)
		filename="${fullname%.*}"
		# extension=$(echo "$fullname" | cut -d . -f2)
		extension="${fullname##*.}"
		convert "$p" -resize "$2" ./c-output/"$filename"."$extension"
	done
}

# 对图片批量添加自定义文本水印
function Embed {
	[ -d "e-output" ] || mkdir e-output
	for p in $(find "$1" -regex  '.*\.jpg\|.*\.svg\|.*\.png'); do
		fullname="$(basename "$p")"
        	# filename=$(echo "$fullname" | cut -d . -f1)
		# extension=$(echo "$fullname" | cut -d . -f2)
		filename="${fullname%.*}"
		extension="${fullname##*.}"

		# 图像宽度
		width=$(identify -format %w "$p")
		# 使用composite指令添加水印
		convert -background '#0008' -fill blue -gravity center \
		-size "${width}"x30 caption:"$2" "$p" +swap -gravity south \
		-composite ./e-output/"$filename"."$extension"
	done
}

# 批量重命名（统一添加文件名前缀或后缀，不影响原始文件扩展名）
function addPrefix {
	[ -d "p-output" ] || mkdir p-output;
	for p in "$1"*.*; do
		fullname=$(basename "$p")
        	# filename=$(echo "$fullname" | cut -d . -f1)
		# extension=$(echo "$fullname" | cut -d . -f2)
		filename="${fullname%.*}"
		extension="${fullname##*.}"
		cp "$p" ./p-output/"$2""$filename"."$extension"
	done
}
function addSuffix {
	[ -d "s-output" ] || mkdir s-output;
	for p in "$1"*.*; do
		fullname=$(basename "$p")
		# filename=$(echo "$fullname" | cut -d . -f1)
		# extension=$(echo "$fullname" | cut -d . -f2)
		filename="${fullname%.*}"
		extension="${fullname##*.}"
		cp "$p" ./s-output/"$filename""$2"."$extension"
	done
}

# 将png/svg图片统一转换为jpg格式图片
function Cvt2JPG {
	[ -d "v-output" ] || mkdir v-output
	for p in $(find "$1" -regex '.*\.svg\|.*\.png');do	
		fullname=$(basename "$p")
	        # filename=$(echo "$fullname" | cut -d . -f1)
		# extension=$(echo "$fullname" | cut -d . -f2)
		filename="${fullname%.*}"
		extension="${fullname##*.}"
		convert "$p" ./v-output/"$filename"".jpg"
	done
}

# main

dir=""

if [[ "$#" -lt 1 ]]; then
	echo "You need to input something"
else 
	while [[ "$#" -ne 0 ]]; do
		case "$1" in
			"-d")
				dir="$2"
				shift 2
				;;
				
			"-j")
				if [[ "$2" != '' ]]; then 
					JPGCompress "$dir" "$2"
					shift 2
				else 
					echo "You need to put in a quality parameter"
				fi
				;;
				
			"-c")
				if [[ "$2" != '' ]]; then 
					CompressResolution "$dir" "$2"
					shift 2
				else 
					echo "You need to put in a resize rate"
				fi
				;;
				
			"-e")
				if [[ "$2" != '' ]]; then 
					Embed "$dir" "$2"
					shift 2
				else 
					echo "You need to input a string to be embeded into pictures"
				fi
				;;
				
			"-p")
				if [[ "$2" != '' ]]; then 
					addPrefix "$dir" "$2"
					shift 2
				else 
					echo "You need to input a prefix"
				fi
				;;
				
			"-s")
				if [[ "$2" != '' ]]; then 
					addSuffix "$dir" "$2"
					shift 2
				else 
					echo "You need to input a suffix"
				fi
				;;
			
			"-v")
				Cvt2JPG "$dir"
				shift
				;;
				
			"-h")
				Instructions
				shift
				;;
		esac
	done
fi
