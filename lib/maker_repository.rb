# (in lib/maker_repository.rb)
require_relative 'maker'
require_relative 'database_connection'
require 'bcrypt'

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

  def create(maker) # Inserts a new Maker in the table makers, returns nothing
    encrypted_password = BCrypt::Password.create(maker.password)
    params = [maker.name, maker.email, maker.username, encrypted_password]
    sql = 'INSERT INTO makers (name, email, username, password) VALUES ($1, $2, $3, $4);'
    result_set = DatabaseConnection.exec_params(sql, params)
  end

  def sign_in(email, submitted_password)
    user = find_by_email(email)

    return nil if user.nil?

    # Compare the submitted password with the encrypted one saved in the database
    stored_password = BCrypt::Password.new(user.password)
    if stored_password == submitted_password
      return true
    else
      return false
    end
  end

  def find(id) # finds a Maker by id
    sql = 'SELECT id, name, email, username, password FROM makers WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]
    maker = Maker.new
    maker.id = record['id']
    maker.name = record['name']
    maker.email = record['email']
    maker.username = record['username']
    maker.password = record['password']
    return maker
  end
  
  def find_by_email(email) # finds a Maker by email
    sql = 'SELECT id, name, email, username, password FROM makers WHERE email = $1;'
    sql_params = [email]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]
    maker = Maker.new
    maker.id = record['id']
    maker.name = record['name']
    maker.email = record['email']
    maker.username = record['username']
    maker.password = record['password']
    return maker
  end
end