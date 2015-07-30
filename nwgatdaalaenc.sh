#!/bin/bash
clear
echo ""
echo "### nwgat.ninja simple daala encoder ###"
echo ""
echo "File to encode (use tab to select)"

read -e file

echo "Number of Frames to skip (blank blank if none)"
read skip

echo "Number of frames to encode (leave blank if none)"
read limit

echo "Video Quality (0-511, where 0 is best quality)"
read vq

echo "Video Complexity (0-10, where 10 is best quality)"
read vz

read -p "Do you want a uncompressed video + png frame file? (y/n) " dump
if [ "$dump" = "y" ]; then
echo ""
./encoder_example -S $skip -l $limit -v $vq -z $vz $file -o $file.v$vq.z$vz.ogv
#./encoder_example -v $vq -z $vz $file -o $file.v$vq.z$vz.ogv
./dump_video $file.v$vq.z$vz.ogv -o $file.v$vq.z$vz.ogv.y4m
ffmpeg -i $file.v$vq.z$vz.ogv.y4m -f image2 -t 0.001 -vframes 1 $file.v$vq.z$vz.ogv.y4m.png
else
echo ""
./encoder_example -S $skip -l $limit -v $vq -z $vz $file -o $file.v$vq.z$vz.ogv

fi
echo ""
