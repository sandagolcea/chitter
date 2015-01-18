require 'sinatra/base'
require_relative 'data_mapper_setup'

class Chitter < Sinatra::Base

  get '/' do
    @peeps = Peep.all
    erb :index
  end

  post '/peeps' do
    message = params["message"]

    hashtags = params["hashtags"].split(" ").map do |hashtag|
      Hashtag.first_or_create(:text => hashtag)
    end
    
    Peep.create(:message => message, :hashtags => hashtags)

    redirect to('/')
  end

  get '/hashtags/:text' do
  hashtag = Hashtag.first(:text => params[:text])
  @peeps = hashtag ? hashtag.peeps : []
  erb :index
end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
