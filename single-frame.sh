#!/bin/bash

input=$1
time=$2

if [ -z "$1" -o -z "$2" ]; then
    echo "Usage: ./single-frame.sh filename frame"
    echo "filename - name of the video"
    echo "frame - when you want to take the frame, in seconds"
    exit 1
fi

ffmpeg -ss $time -i $input -qscale:v 2 -vframes 1 output.jpg
