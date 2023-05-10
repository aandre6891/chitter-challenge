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
      expect(response.body).to include('<h3>Welcome to Chitter!</h3>')
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
      
      expect(response.status).to eq 200
      expect(response.body).to include('Welcome Jordan!')
    end
  end
  
  context "POST /login" do
    it 'should show the user page' do
      response = post(
        "/login", 
        username: "ilaria678",
        password: "as89v89sdg98"
      )
      
      response.should redirect_to("/user/2")
    end
  end
end