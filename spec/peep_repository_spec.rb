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
        expect(peeps[2].content).to eq('Hello, this is the content of the third.')
        expect(peeps[3].time).to eq('2023-04-10 04:05:06')
      end
    end
  end
end



# # 2
# # Create a new Peep

# repo = PeepRepository.new

# repo.crete('Post 5', 'Hello, this is the content of the fourth.', '2023-04-22 18:51:06', '1')

# all_peeps = repo.all
# last_peep = all_peeps.last

# all_peeps.length # =>  5
# last_peep.id # =>  '5'
# last_peep.maker_id # =>  '1'
# last_peep.title # =>  'Post 5'
# last_peep.content # => 'Hello, this is the content of the fourth.'


# # 3
# # Get a single Peep

# repo = PeepRepository.new

# selected_peep = repo.find(2)

# selected_peep.id # =>  '2'
# selected_peep.title # =>  'Post 2'
# selected_peep.content # =>  'Hello, this is the content of the second post.'
# selected_peep.time # =>  '2023-02-24 04:05:06'
# selected_peep.maker_id # =>  '1'