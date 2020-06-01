require 'sinatra/base'
require 'sidekiq'
require 'sidekiq/api'
require 'sidekiq/web'

require_relative 'workers/convert.rb'

class App < Sinatra::Application
  get '/' do
    @current_files = Dir['ready/*.mp3'].sort_by { |x| File.mtime(x) }.reverse.first(20)
    erb :begin
  end

  post '/' do
    # TODO: validate URLs are actually URLs. See https://stackoverflow.com/questions/1805761/how-to-check-if-a-url-is-valid
    @url_list = params['url-list'].split(/[\r\n]+/).map { |u| { url: u, job: nil } }
    @url_list.each do |u|
      puts "Queueing #{u[:url]}"
      u[:job] = Convert.perform_async(u[:url])
    end

    erb :success
  end

  get '/ready/:file' do |file|
    attachment
    send_file "ready/#{file}"
  end

  get '/ready/:file/listen' do |file|
    send_file "ready/#{file}"
  end
end
