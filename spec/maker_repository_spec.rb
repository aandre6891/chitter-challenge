# file: spec/maker_repository_spec.rb
require_relative '../lib/maker_repository'
require_relative '../lib/database_connection'
require_relative '../lib/maker'

RSpec.describe MakerRepository do
  def reset_makers_table
    seed_sql = File.read('spec/seeds/chitter_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_db_test' })
    connection.exec(seed_sql)
  end
  
  describe MakerRepository do
    before(:each) do 
      reset_makers_table
    end
    
    describe '#all' do
      it 'returns all makers' do
        
        repo = MakerRepository.new
        makers = repo.all
        
        expect(makers.length).to eq 4
        expect(makers[0].id).to eq('1')
        expect(makers[1].name).to eq('Ilaria')
        expect(makers[2].email).to eq('chiara@fakemail.com')
        expect(makers[3].username).to eq('barbara668')
      end
    end
    
    describe '#create' do
      it 'creates a new maker' do
            
        repo = MakerRepository.new
        new_maker = Maker.new
        new_maker.name = 'Daniele'
        new_maker.email = 'daniele@fakemail.com'
        new_maker.username = 'daniele678'
        new_maker.password = 'asdlkasd9787'
        repo.create(new_maker)
        
        makers = repo.all
        last_maker = makers.last
        
        expect(makers.length).to eq(5)
        expect(last_maker.id).to eq('5')
        expect(last_maker.name).to eq('Daniele')
        expect(last_maker.email).to eq('daniele@fakemail.com')
        expect(last_maker.username).to eq('daniele678')
      end
    end    

    describe '#find' do
      it 'finds a maker by id' do
    
        repo = MakerRepository.new
        
        selected_maker = repo.find(3)
        
        expect(selected_maker.id).to eq('3')
        expect(selected_maker.name).to eq('Chiara')
        expect(selected_maker.email).to eq('chiara@fakemail.com')
        expect(selected_maker.username).to eq('chiara6647')
      end
    end
  end    
end




