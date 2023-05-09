require_relative '../lib/peep_repository'

RSpec.describe PeepRepository do
  def reset_all_tables
    seed_sql = File.read('spec/seeds/chitter_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_db_test' })
    connection.exec(seed_sql)
  end

  describe PeepRepository do
    before(:each) do 
      reset_all_tables
    end

    describe '#all' do
      it "returns all Peeps" do
          
        repo = PeepRepository.new
        
        peeps = repo.all
        
        expect(peeps.length).to eq(4)
        expect(peeps.first.id).to eq('1')
        expect(peeps.first.maker_id).to eq('2')
        expect(peeps[1].title).to eq('Post 2')
        expect(peeps[2].content).to eq('Hello, this is the third content.')
        expect(peeps[3].time).to eq('2023-04-10 04:05:06')
      end
    end
    
    describe '#create' do
      it "creates a new Peep" do 
        repo = PeepRepository.new
        
        repo.create('Post 5', 'Hello, this is the fourth content.', '2023-04-22 18:51:06', '1')
        
        all_peeps = repo.all
        last_peep = all_peeps.last
        
        expect(all_peeps.length).to eq(5)
        expect(last_peep.id).to eq('5')
        expect(last_peep.maker_id).to eq('1')
        expect(last_peep.title).to eq('Post 5')
        expect(last_peep.content).to eq('Hello, this is the fourth content.')
      end
    end

    describe '#find' do
      it "returns a single Peep" do
      
        repo = PeepRepository.new
        
        selected_peep = repo.find(2)
        
        expect(selected_peep.id).to eq('2')
        expect(selected_peep.title).to eq('Post 2')
        expect(selected_peep.content).to eq('Hello, this is the content of the second post.')
        expect(selected_peep.time).to eq('2023-02-24 04:05:06')
        expect(selected_peep.maker_id).to eq('1')
      end
    end
  end
end




