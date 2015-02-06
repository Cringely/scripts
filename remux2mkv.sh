#!/bin/bash  
# change .MTS to the filetype you want to remux to mkv
for file in *.MTS; do mkvmerge $file -o $file.mkv;done  
