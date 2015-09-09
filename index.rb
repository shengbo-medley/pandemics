require 'sinatra'
require "sinatra/config_file"

config_file 'config/settings.yml'

get '/' do
  @current_status = `cd "#{settings.repogitory_path}" && git st`
  erb :index
end


get '/check_out_develop' do
  @current_status = `cd "#{settings.repogitory_path}" && git checkout develop`
  erb :index
end


get '/start_to_release' do
  @current_status = `cd "#{settings.repogitory_path}" && git branch`
  `cd #{settings.repogitory_path} && git checkout develop && git checkout -b release/#{Time.now.strftime('%Y%m%d%H%M%S')}` unless @current_status.match(/release/)
  @current_status = `cd "#{settings.repogitory_path}" && git log ..origin/master --no-merges --pretty=format:"#{settings.commit_base_url}%H %an %s"`
  erb :index
end
