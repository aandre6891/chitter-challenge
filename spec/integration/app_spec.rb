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
      expect(response.body).to include('Log In to post a peep!')
    end
  end
end