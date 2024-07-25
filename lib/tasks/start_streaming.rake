namespace :streaming do
  desc "Start RTSP to HLS streaming"
  task start: :environment do
    camera_rtsp_url = "rtsp://Paul14930:Romain1414!!!!@192.168.1.148:554/live/ch1"
    stream_command = "ffmpeg -i \"#{camera_rtsp_url}\" -c:v libx264 -preset veryfast -crf 23 -c:a aac -strict -2 -f hls -hls_time 2 -hls_list_size 5 -hls_wrap 10 #{Rails.root.join('public', 'stream.m3u8')}"
    system(stream_command)
  end
end
