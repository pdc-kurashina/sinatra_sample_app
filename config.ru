# config.ru
require 'sinatra'
require './your_script'

set :port, 4567

run Sinatra::Application
