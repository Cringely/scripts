# written by nwgat
# CC-BY https://nwgat.ninja

ffmpeg -i bbb_sunflower_1080p_30fps_normal.mp4 \
  -f webm -cluster_size_limit 2M -cluster_time_limit 5100 -content_type video/webm \
  -vf scale=1280:-1 -r 30 -ac 2 \
  -acodec libopus -b:a 64K \
  -vcodec libvpx -b:v 2.5M -crf 30 -g 150 -deadline realtime -threads 8 \
  icecast://source:passwordP@ninja.domain:8000/live.webm