require 'sinatra/base'
require_relative 'data_mapper_setup'

class Chitter < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'

  def current_maker
    @current_maker ||= Maker.get(session[:maker_id]) if session[:maker_id]
  end


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

  get '/makers/new' do
    erb :"/maker/new"
  end

  post '/makers' do
    maker = Maker.create(:name => params[:name],
              :user_name => params[:user_name],
              :email => params[:email],
              :password => params[:password])
    session[:maker_id] = maker.id
    redirect to('/')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
