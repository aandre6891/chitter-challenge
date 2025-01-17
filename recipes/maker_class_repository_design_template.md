# Chitter Challenge Model and Repository Classes Design Recipe

STRAIGHT UP

As a Maker
So that I can let people know what I am doing  
I want to post a message (peep) to chitter

As a maker
So that I can see what others are saying  
I want to see all peeps in reverse chronological order

As a Maker
So that I can better appreciate the context of a peep
I want to see the time at which it was made

As a Maker
So that I can post messages on Chitter as me
I want to sign up for Chitter

HARDER

As a Maker
So that only I can post messages on Chitter as me
I want to log in to Chitter

As a Maker
So that I can avoid others posting messages on Chitter as me
I want to log out of Chitter

ADVANCED

As a Maker
So that I can stay constantly tapped in to the shouty box of Chitter
I want to receive an email if I am tagged in a Peep

## 1. Design and create the Table

(<!-- If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
(done)
```

## 2. Create Test SQL seeds (done)

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
TRUNCATE TABLE makers, peeps RESTART IDENTITY;

INSERT INTO makers (name, email, username, password) VALUES 
('Andrea', 'ruggieri6891@gmail.com', 'andre6891', 'graves86'),
('Ilaria', 'ilaria@fakemail.com', 'ilaria678', 'as89v89sdg98'),
('Chiara', 'chiara@fakemail.com', 'chiara6647', '778asd9svh'),
('Barbara', 'barbara@fakemail.com', 'barbara668', 'asd789sdf');

INSERT INTO peeps (title, content, time, maker_id) VALUES 
('Post 1', 'Hello, this is the first content.', '2023-01-08 04:05:06', '2'),
('Post 2', 'Hello, this is the content of the second post.', '2023-02-24 04:05:06', '1'),
('Post 3', 'Hello, this is the content of the third.', '2023-03-30 04:05:06', '3'),
('Post 4', 'Hello, this is the content of the fourth.', '2023-04-10 04:05:06', '4');

```bash

```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: makers

# Model class
# (in lib/maker.rb)
class Maker
end

# Repository class
# (in lib/maker_repository.rb)
class MakerRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: makers

# Model class
# (in lib/maker.rb)

class Maker

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :email, :username, :password
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: makers

# Repository class
# (in lib/maker_repository.rb)

class MakerRepository
  def all
    # Executes the SQL query:
    # SELECT id, name, email, username, password FROM makers;

    # Returns an array of Maker objects.
  end

  def create(name, email, username, password)
    # Executes the SQL query:
    # INSERT INTO makers (name, email, username, password) VALUES ($1, $2, $3, $4);

    # Inserts a new Maker in the table makers
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, email, username, password FROM makers WHERE id = $1;

    # Returns a single Maker object.
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all makers

repo = MakerRepository.new

makers = repo.all

makers.length # =>  '4'

makers[0].id # =>  1
makers[1].name # =>  'Ilaria'
makers[2].email # =>  'chiara@fakemail.com'
makers[3].username # =>  'barbara668'

# 2
# Create a new maker

repo = MakerRepository.new

new_maker = repo.create('Daniele', 'daniele@fakemail.com', 'daniele678', 'asdlkasd9787')

repo.all # => '5'

last_maker = repo.all.last

last_maker.id # =>  5
last_maker.name # =>  'Daniele'
last_maker.email # =>  'daniele@fakemail.com'
last_maker.username # => 'daniele678'

# 3
# Get a single maker

repo = MakerRepository.new

maker = repo.find(3)

maker.id # =>  3
maker.name # =>  'Chiara'
maker.email # =>  'chiara@fakemail.com'
maker.username # =>  'chiara6647'

# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->