class Convert
  include Sidekiq::Worker
    
  def perform(url)
    puts "Converting #{url}"
    puts `youtube-dl -x --audio-format mp3 --no-mtime -o "ready/%(title)s.%(ext)s" #{url}`
  end
end
