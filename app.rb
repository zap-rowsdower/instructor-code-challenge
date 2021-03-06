require 'sinatra'
require 'json'

get '/' do
  @faves = JSON.parse(File.read('data.json'))
  erb :index
end

get '/favourites' do
  response.header['Content-Type'] = 'application/json'
  @file = File.read('data.json')
end

post '/favourites' do
  file = JSON.parse(File.read('data.json'))

  unless params[:name] && params[:oid]
    return 'Invalid Request'
  end
  
  movie = { name: params[:name], oid: params[:oid] }
  file << movie
  File.write('data.json',JSON.pretty_generate(file))
  movie.to_json

  redirect to('/')
end
