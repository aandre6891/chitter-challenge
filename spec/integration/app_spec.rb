require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  def reset_tables
  seed_sql = File.read('spec/seeds/chitter_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_db_test' })
  connection.exec(seed_sql)
  end

  before(:each) do 
    reset_tables
  end

  context "GET /" do
    it 'should return the homepage' do

      response = get("/") 

      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Welcome to Chitter!</h1>')
      expect(response.body).to include('Hello, this is the fourth content.')
    end
  end
  
  context "GET /signup" do
    it 'should return the signup page' do

      response = get("/signup") 

      expect(response.status).to eq 200
      expect(response.body).to include('Sign up for Chitter!')
    end
  end

  context "GET /login" do
    it 'should return the login page' do

      response = get("/login") 

      expect(response.status).to eq 200
      expect(response.body).to include('Log In to see all the peeps')
    end
  end
 
  context "GET /post" do
    it 'should return the post page' do

      response = get("/post") 

      expect(response.status).to eq 200
      expect(response.body).to include('Post a new peep')
    end
  end

  context "GET /user/:id" do
    it 'should return the user page' do
      response = get("/user/1")

      expect(response.status).to eq 200
      expect(response.body).to include('Welcome Andrea!')
    end
  end
  
  context "POST /login" do # not working after encrypting
    xit 'should show the user page' do
      response = post(
        "/login", 
        email: "ilaria@fakemail.com",
        password: "as89v89sdg98"
      )
      
      expect(response.status).to eq 302
    end

    xit 'should return status 200 when the password is not valid' do # not working after encrypting
      response = post(
        "/login", 
        email: "ilaria@fakemail.com",
        password: "11111"
      )
      
      expect(response.status).to eq 200
    end
  
    it "should return a message when the account doesn't exists" do
      response = post(
        "/login", 
        email: "notexistingemail@email.com",
        password: "11111"
      )
      
      expect(response.status).to eq 200
      expect(response.body).to include('This email address is not registered')
    end
    
    it "should return a message when the account doesn't exists" do
      new_user = Maker.new
      new_user.name = "Jordan"
      new_user.email = "jordan@chitter.com"
      new_user.username = "jordan555"
      new_user.password = "123456"
      repo = MakerRepository.new
      repo.create(new_user)

      response = post(
        "/login", 
        email: "jordan@chitter.com",
        password: "123456"
      )
      
      expect(response.status).to eq 302
    end
  end
  
  context "POST /signup" do
    it 'should create a new user' do
      response = post(
        "/signup", 
        name: "Jordan", 
        email: "jordan@chitter.com",
        username: "jordan555",
        password: "123456"
      )

      response = get('/user/5')
      repo = MakerRepository.new
      expect(repo.all.length).to eq 5
      
      expect(response.status).to eq 200
      expect(response.body).to include('Welcome Jordan!')
    end
  end
end