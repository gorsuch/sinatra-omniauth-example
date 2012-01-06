require 'sinatra'
require 'omniauth'

configure do
  enable :sessions
end

configure :development do
  use OmniAuth::Builder do
    provider :developer
  end
end

before do
   if request.path_info != '/auth/developer/callback' 
     redirect '/auth/developer' unless session[:uid]
    end
end

get '/' do
  "hi, #{session[:uid]}"
end

post '/auth/developer/callback' do
  session[:uid] = request.env['omniauth.auth']["uid"]
  redirect '/'
end