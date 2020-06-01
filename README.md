# Arrdio

A simple app to take a URL and attempt to convert it to MP3.

## Details

* Written in Ruby 2.6 and Sinatra (http://sinatrarb.com)
* Minimal frontend. No JS frameworks or NPM/Yarn here. Just Milligram (https://milligram.io/) for the CSS framework and Feather Icons (https://feathericons.com) for some fancy icons. Their minified files were downloaded straight to `public`. Favicons from https://favicon.io
* Once the URL is submitted, a job is queued with Sidekiq to download and convert it. Once the job finishes, the converted file can be found in the `ready` directory.

## Requirements

Your host OS will need `youtube-dl`, `ffmpeg`, and `redis` installed. Your favorite package manager (homebrew, apt, yum, etc) should be able to handle the installation.

## Development

After checking out the repo, run `bundle install` to install dependencies.

## Running the app

* Easiest way: `foreman start`. That will run the app, and the Sidekiq job runner.
* Serving the app: `shotgun -p 4567 config.ru` (if you want the server to reload on change) or `rackup -p 4567`, then visit `http://localhost:4567`
* Running the jobs: `sidekiq -r ./app.rb`
* Monitor the jobs through the Sidekiq interface: `http://localhost:4567/sidekiq`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dotnofoolin/arrdio.

## Inspiration

* https://www.justinweiss.com/articles/turn-ruby-conference-videos-into-your-own-personal-podcast/
* https://github.com/p8952/sinatra-sidekiq
