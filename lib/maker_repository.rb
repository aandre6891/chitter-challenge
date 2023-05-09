# (in lib/maker_repository.rb)

class MakerRepository
  def all
    # Executes the SQL query:
    # SELECT id, name, email, username, password FROM makers;

    # Returns an array of Maker objects.
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