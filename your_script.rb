require 'sinatra'

$data = {}

get '/' do
  'Hello, World!'
end

get '/hello/:name' do
  "Hello, #{params[:name]}!"
end

get '/index' do
  erb :index
end

get '/form' do
  erb :form
end

post '/submit' do
  $data[:name] = params[:name]
  $data[:age] = params[:age]
  redirect '/show'
end

get '/show' do
  erb :show, locals: { name: $data[:name], age: $data[:age] }
end
