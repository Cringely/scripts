@echo off
echo "### nwgat.ninja simple daala encoder (windows)###"

set /p file= File to encode (use tab to select) 
echo %file%
set /p skip= Number of Frames to skip (blank blank if none) 
echo %skip%
set /p limit= Number of frames to encode (leave blank if none) 
echo %limit%
set /p vq= Video Quality (0-511, where 0 is best quality) 
echo %vq%
set /p vz= Video Complexity (0-10, where 10 is best quality) 
echo %vz%


SET /P ANSWER=Do you want a uncompressed video + png frame file? (y/n)? 
echo You chose: %ANSWER% 
if /i {%ANSWER%}=={y} (goto :yes) 
if /i {%ANSWER%}=={yes} (goto :yes) 
goto :no 
:yes 
encoder_example.exe -S %skip% -l %limit% -v %vq% -z %vz% %file% -o %file%.v%vq%.z%vz%.ogv
dump_video.exe %file%.v%vq%.z%vz%.ogv -o %file%.v%vq%.z%vz%.ogv.y4m
ffmpeg.exe -i %file%.v%vq%.z%vz%.ogv.y4m -f image2 -t 0.001 -vframes 1 %file%.v%vq%.z%vz%.ogv.y4m.png
ffmpeg -i %file% -f image2 -vf select="gte(n\, %skip%)" -vframes 1 %file%.src.png

exit /b 0 

:no 
encoder_example.exe -S %skip% -l %limit% -v %vq% -z %vz% %file% -o %file%.v%vq%.z%vz%.ogv
exit /b 1
