require 'sinatra/base'

class Chitter < Sinatra::Base
  require 'data_mapper_setup'
  get '/' do
    erb :index
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
