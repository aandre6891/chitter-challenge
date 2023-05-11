require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/peep_repository'
require_relative 'lib/maker_repository'
require_relative 'lib/maker'
require_relative 'lib/peep'
require_relative 'lib/database_connection'

class Application < Sinatra::Base
  enable :sessions
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
    repo_makers = MakerRepository.new
    repo_peeps = PeepRepository.new
    
    @maker = repo_makers.find(params[:id])
    @peeps = repo_peeps.all
    return erb(:user)
  end

  post '/signup' do
    repo = MakerRepository.new
    email_exists = repo.all.any? { |maker| maker.email == params[:email] }
    username_exists = repo.all.any? { |maker| maker.username == params[:username] }
    return 'A Maker with this email address and username already exists <a href="/signup">Try with another email</a> or <a href="/login">Log In</a>' if email_exists & username_exists
    return 'A Maker with this email address already exists <a href="/signup">Try with another email</a>' if email_exists 
    return 'A Maker with this username address already exists <a href="/signup">Try with another email</a>' if username_exists  
    new_maker = Maker.new
    new_maker.name = params[:name]
    new_maker.email = params[:email]
    new_maker.username = params[:username]
    new_maker.password = params[:password]
    repo.create(new_maker)
    maker_id = repo.find_by_email(new_maker.email)
    redirect '/user/' + maker_id
  end
  
  post '/login' do
    email = params[:email]
    password = params[:password]
    repo = MakerRepository.new
    user = repo.find_by_email(email)

    # This is a simplified way of 
    # checking the password. In a real 
    # project, you should encrypt the password
    # stored in the database.
    if user.password == password
      # Set the user ID in session
      session[:user_id] = user.id
      redirect '/user/' + user.id
    else
      return "Invalid email or password. Go back to <a href='/login'>Login</a> and try again."
    end
  end
end
