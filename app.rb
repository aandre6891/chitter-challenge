require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/peep_repository.rb'
require_relative 'lib/database_connection'

class Application < Sinatra::Base
  DatabaseConnection.connect('chitter_db_test')
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    all_peeps= PeepRepository.new
    @peeps = all_peeps.all
    return erb(:index)
  end

  get '/signup' do
    return erb(:signup)
  end
  
  get '/login' do
    return erb(:login)
  end
end