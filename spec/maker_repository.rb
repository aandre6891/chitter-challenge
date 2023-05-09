# file: spec/maker_repository_spec.rb

def reset_makers_table
  seed_sql = File.read('spec/chitter_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_db_test' })
  connection.exec(seed_sql)
end

describe MakerRepository do
  before(:each) do 
    reset_makers_table
  end

# 1
# Get all makers

repo = MakerRepository.new

makers = repo.all

makers.length # =>  '4'

makers[0].id # =>  1
makers[1].name # =>  'Ilaria'
makers[2].email # =>  'chiara@fakemail.com'
makers[3].username # =>  'barbara668'

end


# # 1
# # Get all makers

# repo = MakerRepository.new

# makers = repo.all

# makers.length # =>  '4'

# makers[0].id # =>  1
# makers[1].name # =>  'Ilaria'
# makers[2].email # =>  'chiara@fakemail.com'
# makers[3].username # =>  'barbara668'

# # 2
# # Create a new maker

# repo = MakerRepository.new

# new_maker = repo.create('Daniele', 'daniele@fakemail.com', 'daniele678', 'asdlkasd9787')

# repo.all # => '5'

# last_maker = repo.all.last

# last_maker.id # =>  5
# last_maker.name # =>  'Daniele'
# last_maker.email # =>  'daniele@fakemail.com'
# last_maker.username # => 'daniele678'

# # 3
# # Get a single maker

# repo = MakerRepository.new

# maker = repo.find(3)

# maker.id # =>  3
# maker.name # =>  'Chiara'
# maker.email # =>  'chiara@fakemail.com'
# maker.username # =>  'chiara6647'