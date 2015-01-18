require 'sinatra/base'
require_relative 'data_mapper_setup'

class Chitter < Sinatra::Base

  get '/' do
    @peeps = Peep.all
    erb :index
  end

  post '/peeps' do
    name = params["name"]
    user_handle = params["user_handle"]
    message = params["message"]

    hashtags = params["hashtags"].split(" ").map do |hashtag|
      Hashtag.first_or_create(:text => hashtag)
    end
    
    Peep.create(:name => name, :user_handle => user_handle, :message => message, :hashtags => hashtags)

    redirect to('/')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
