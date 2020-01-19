#!/bin/bash

# where your gopro movies are exported
rootdir="/Users/(your username)/Pictures/GoPro/"
# check if everything is alright
workdir="/Users/(your username)/Desktop/" 
# name of the gopro. those blanks are annoying
gopro="/HERO3+\ Black\ Edition\ 2/" 
# where you want to save the movie
savedir="/Users/(your username)/Desktop/" 
dirs=$(ls -1 $rootdir)
date=`date "+%Y%m%d"`
# rate of compression (-crf).
rate=32 

# list of movies to concatenate. you can ignore it.
echo "" > con_gp.txt 

for dir in $dirs; do
  mov_files=`ls -1 "$rootdir$dir${gopro[*]}"`
    for file in $mov_files; do
      echo "file $rootdir$dir${gopro}$file" >> con_gp.txt
    done
done

ffmpeg -safe 0 -f concat -i con_gp.txt -c:v copy -c:a copy -c:s copy -map 0:v -map 0:a? -map 0:s? $workdir${date}_GP.mp4

ffmpeg -i $workdir${date}_GP.mp4 -crf $rate -pix_fmt yuv420p ${savedir}/crf_movies/${date}_GP_crf$rate.mp4
