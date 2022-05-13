#!/bin/bash
MP4FILE=$(ls $1 |grep .mp4) # Original source was hard-coded to a dir.
for filename in $MP4FILE
do 
    name=`echo "$filename" | sed -e "s/.mp4$//g"`
    ffmpeg -i filename.mp4 -vn -acodec pcm_s16le -ar 44100 -ac 2 name.wav
 ffmpeg -i $1/$filename -b:a 192K -vn $1/$name.mp3
done
