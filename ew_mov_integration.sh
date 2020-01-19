#!/bin/bash

# where your SD card is
dir="/Volumes/(your SD name)/VIDEO/"
# check if everything is alright
workdir="/Users/(your username)/Desktop/"
# where you want to save the movie
savedir="/Users/(your username)/Desktop/"
files=$(ls -1 $dir)
date=`date "+%Y%m%d"`
# rate of compression (-crf).
rate=32
type=".mp4"

# list of movies to concatenate. you can ignore it.
echo "" > con_ew.txt

for file in $files; do
  ffmpeg -i $dir$file -crf $rate -pix_fmt yuv420p $workdir${file%%.*}_crf$rate$type
  echo "file $workdir${file%%.*}_crf$rate$type" >> con_ew.txt
done

ffmpeg -safe 0 -f concat -i con_ew.txt -c:v copy -c:a copy -c:s copy -map 0:v -map 0:a? -map 0:s? $workdir${date}_EW$type

ffmpeg -i $workdir${date}_EW$type -crf $rate -pix_fmt yuv420p ${savedir}/crf_movies/${date}_EW_crf$rate$type
