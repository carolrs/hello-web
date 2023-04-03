require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base

  get '/names' do

    names = params[:names]
    return names
    # This route is not executed (the path doesn't match).    
  end

  post '/sort-names' do
    names = params[:names]

    return names.split(",").sort!.join(",")
    # This route matches! The code inside the block will be executed now.
  end

  post '/submit' do

    name = params[:name]
    message = params[:message]

    return "Thanks #{name}, you sent this message: #{message}"
    # This route matches too, but will not be executed.
    # Only the first one matching (above) is.
  end
  # # This allows the app code to refresh
  # # without having to restart the server.
  configure :development do
  register Sinatra::Reloader

  end
end