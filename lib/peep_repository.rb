require_relative 'peep'

class PeepRepository
  def initialize # initialize an empty array
    @peeps = []
  end

  def all # returns an array of Peep objects

    sql = 'SELECT id, title, content, time, maker_id FROM peeps;'
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      peep = Peep.new
      peep.id = record['id']
      peep.title = record['title']
      peep.content = record['content']
      peep.time = record['time']
      peep.maker_id = record['maker_id']

      @peeps << peep
    end
    return @peeps
  end
  
  # def create
  #   # Executes the SQL query:
  #   # INSERT INTO peeps (title, content, time, maker_id) VALUES ($1, $2, $3, $4);

  #   # Inserts a new Peep in the table peeps
  # end

  # # Gets a single record by its ID
  # # One argument: the id (number)
  # def find(id) # can be useful?
  #   # Executes the SQL query:
  #   # SELECT id, title, content, time, maker_id FROM peeps WHERE id = $1;

  #   # Returns a single Peep object.
  # end
end