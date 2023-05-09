# (in lib/maker_repository.rb)

require_relative 'database_connection'

class MakerRepository
  def initialize # initializes an empty array of makers
    @makers = []
  end

  def all
    sql = 'SELECT id, name, email, username, password FROM makers;'
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      maker = Maker.new
      maker.id = record['id']
      maker.name = record['name']
      maker.email = record['email']
      maker.username = record['username']
      maker.password = record['password']

      @makers << maker
    end
    return @makers
  end

  # def create
  #   # Executes the SQL query:
  #   # INSERT INTO makers (name, email, username, password) VALUES ($1, $2, $3, $4);

  #   # Inserts a new Maker in the table makers
  # end

  # # Gets a single record by its ID
  # # One argument: the id (number)
  # def find(id)
  #   # Executes the SQL query:
  #   # SELECT id, name, email, username, password FROM makers WHERE id = $1;

  #   # Returns a single Maker object.
  # end
end