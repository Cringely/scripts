echo "<<< Nwgat Matroska Batch Subtitle Muxer v1 >>>"

echo "what do you want to remux? (mp4 ts avi..)"
read type

echo "Subtitles delay (in ms)"
read sync

echo "Subtitle Language (jpn nor eng..)"
read lang 


for i in *.$type
do
    i="${i%.$type}"
    /cygdrive/c/mkvtoolnix/mkvmerge.exe -o "$i.out.mkv" "$i.$type" "--language" "0:$lang" "--sync" "0:"$sync"" "$i.ass"
done
