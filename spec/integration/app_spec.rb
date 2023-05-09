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
  seed_sql = File.read('spec/seeds/music_library.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
  end

  before(:each) do 
    reset_tables
  end

  # context "GET /albums" do # example
  #   it "should return the links to the albums" do
  #     response = get("/albums")
      
  #     expect(response.status).to eq 200
  #     expect(response.body).to include('<a href="/albums/1">Doolittle</a><br/>')
  #     expect(response.body).to include('<a href="/albums/2">Surfer Rosa</a><br/>')
  #     expect(response.body).to include('<a href="/albums/3">Waterloo</a><br/>')
  #     expect(response.body).to include('<a href="/albums/12">Ring Ring</a><br/>')
  #   end
  # end

  # context "POST /albums" do # example
  #   it "should validate album parameters" do
  #     response = post("/albums", 
  #       invalid_artist_title: 'OK Computer', 
  #       another_invalid_parameter: 'invalid parameter'
  #     )  

  #     expect(response.status).to eq(400) 
  #   end
end