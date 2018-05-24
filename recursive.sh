#!/bin/bash
DEST_DIR="/Users/zyj/Desktop"


function travel(){
	for filename in $(ls $1)
	do
		file_dir=$1"/"$filename
		suffix=${file_dir##*.}
		if [[ -d $file_dir ]]; then
			travel $file_dir
		elif [[ $suffix"x" = "mp4""x" || $suffix"x" = "mkv""x" || $suffix"x" = "avi""x" || $suffix"x" = "rmvb""x" ]]; then
			echo $file_dir
			# ffmpeg -xx -x -a $file_dir -o /xxx/xxx/output.mp4
		fi
	done  
}


travel $DEST_DIR
echo "OK"