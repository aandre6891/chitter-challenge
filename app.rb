require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/peep_repository'
require_relative 'lib/maker_repository'
require_relative 'lib/maker'
require_relative 'lib/peep'
require_relative 'lib/database_connection'

DatabaseConnection.connect

class Application < Sinatra::Base
  enable :sessions
  # This allows the app code to refresh
  # without having to restart the server.
  
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    unless session[:user_id] == nil
      repo_maker = MakerRepository.new
      @maker = repo_maker.find(session[:user_id])
    end

    repo_peep = PeepRepository.new
    @peeps = repo_peep.all
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
    new_user = Maker.new
    new_user.name = params[:name]
    new_user.email = params[:email]
    new_user.username = params[:username]
    new_user.password = params[:password]
    repo.create(new_user)
    user = repo.find_by_email(new_user.email)
    session[:user_id] = user.id
    redirect '/account'
  end
  
  post '/login' do
    email = params[:email]
    password = params[:password]
    repo = MakerRepository.new
    
    if !repo.all.any? { |maker| maker.email == email }
      return "This email address is not registered. Go back to the <a href='/login'>Log In</a> and try again."
    end

    user = repo.find_by_email(email)
    

    if repo.sign_in(email, password) == true
      session[:user_id] = user.id
      redirect '/account'
    else
      return "Invalid password. Go back to the <a href='/login'>Log In</a> and try again."
    end
  end

  get '/account' do
    if session[:user_id] == nil
      # No user id in the session
      # so the user is not logged in.
      return redirect('/login')
    else
      repo_makers = MakerRepository.new
      repo_peeps = PeepRepository.new
    
      @maker = repo_makers.find(session[:user_id])
      @peeps = repo_peeps.all
      return erb(:account)
    end
  end

  post '/logout' do
    session[:user_id] = nil
    redirect '/login'
  end
end
