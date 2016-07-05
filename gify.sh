#!/bin/sh


# format is mm:ss
filename=$1
start_time=$2
duration=$3

if [ -z "$1" -o -z "$2" -o -z "$3" ]; then
    echo "Usage: ./single-frame.sh filename start-time duration"
    echo "filename - name of the video"
    echo "start-time - when you start capturing frames"
    echo "duration - how long you want to capture frames for"
    exit 1
fi

output="output.gif"
palette="palette.gif"
filters="fps=10,scale=320:-1:flags=lanczos"

echo creating palette
ffmpeg -v warning -ss $start_time -t $duration -i $filename -vf scale=300:-1:sws_dither=ed -y $palette

echo creating gif
ffmpeg -v warning -ss $start_time -t $duration -i $filename -vf "$filters,palettegen" -y $palette
ffmpeg -v warning -ss $start_time -t $duration -i $filename -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y $output

echo cleaning up
rm $palette
