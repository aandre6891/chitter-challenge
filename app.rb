require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/peep_repository'
require_relative 'lib/maker_repository'
require_relative 'lib/maker'
require_relative 'lib/peep'
require_relative 'lib/database_connection'

class Application < Sinatra::Base
  DatabaseConnection.connect('chitter_db_test')
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    repo = PeepRepository.new
    @peeps = repo.all
    return erb(:index)
  end

  get '/signup' do
    return erb(:signup)
  end
  
  get '/login' do
    return erb(:login)
  end
  
  get '/post' do
    return erb(:post)
  end
  
  get '/user/:id' do
    repo = MakerRepository.new
    @maker = repo.find(params[:id])
    return erb(:user)
  end

  post '/signup' do
    repo = MakerRepository.new
    new_maker = Maker.new
    new_maker.name = params[:name]
    new_maker.email = params[:email]
    new_maker.username = params[:username]
    new_maker.password = params[:password]
    repo.create(new_maker)

    maker_id = repo.find_by_email(params[:email])
    redirect '/user/' + maker_id
  end
end
