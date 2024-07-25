# lib/tasks/start_streaming.rake
namespace :streaming do
  desc "Start RTSP to HLS streaming"
  task start: :environment do
    camera_rtsp_url = "rtsp://Paul14930:Romain1414!!!!@192.168.1.148:554/live/ch1"
    stream_command = <<-CMD
      ffmpeg -rtsp_transport tcp -i "#{camera_rtsp_url}" -vcodec libx264 -acodec aac -strict -2 -f hls -hls_time 2 -hls_list_size 5 -hls_wrap 10 -start_number 1 #{Rails.root.join('public', 'stream.m3u8')}
    CMD
    puts "Running command: #{stream_command}"
    system(stream_command)
  end
end
