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
  
  def create(title, content, time, maker_id) # creates a new Peep object, returns nothing
    sql = 'INSERT INTO peeps (title, content, time, maker_id) VALUES ($1, $2, $3, $4);'
    params = [title, content, time, maker_id]
    result_set = DatabaseConnection.exec_params(sql, params)
  end

  def find(id) # returns a single Peep object
    sql = 'SELECT id, title, content, time, maker_id FROM peeps WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)

    record = result_set.first
    selected_peep = Peep.new
    
    selected_peep.id = result_set.first['id']
    selected_peep.title = result_set.first['title']
    selected_peep.content = result_set.first['content']
    selected_peep.time = result_set.first['time']
    selected_peep.maker_id = result_set.first['maker_id']

    return selected_peep
  end
end