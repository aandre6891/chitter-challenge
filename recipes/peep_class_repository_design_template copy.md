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
# Table name: peeps

# Model class
# (in lib/peep.rb)
class Peep
end

# Repository class
# (in lib/peep_repository.rb)
class PeepRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: peeps

# Model class
# (in lib/peep.rb)

class Peep

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :content, :time, :maker_id
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
# Table name: peeps

# Repository class
# (in lib/peep_repository.rb)

class PeepRepository
  def all
    # Executes the SQL query:
    # SELECT id, title, content, time, maker_id FROM peeps;

    # returns an array of Peep objects
  end
  
  def create
    # Executes the SQL query:
    # INSERT INTO peeps (title, content, time, maker_id) VALUES ($1, $2, $3, $4);

    # Inserts a new Peep in the table peeps
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id) # can be useful?
    # Executes the SQL query:
    # SELECT id, title, content, time, maker_id FROM peeps WHERE id = $1;

    # Returns a single Peep object.
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all Peeps

repo = PeepRepository.new

peeps = repo.all

peeps.length # =>  4

peeps.first.id # =>  '1'
peeps.first.maker_id # =>  '2'
peeps[1].title # =>  'Post 2'
peeps[2].content # =>  'Hello, this is the content of the third.'
peeps[3].time # =>  '2023-04-10 04:05:06'


# 2
# Create a new Peep

repo = PeepRepository.new

repo.crete('Post 5', 'Hello, this is the content of the fourth.', '2023-04-22 18:51:06', '1')

all_peeps = repo.all
last_peep = all_peeps.last

all_peeps.length # =>  5
last_peep.id # =>  '5'
last_peep.maker_id # =>  '1'
last_peep.title # =>  'Post 5'
last_peep.content # => 'Hello, this is the content of the fourth.'


# 3
# Get a single Peep

repo = PeepRepository.new

selected_peep = repo.find(2)

selected_peep.id # =>  '2'
selected_peep.title # =>  'Post 2'
selected_peep.content # =>  'Hello, this is the content of the second post.'
selected_peep.time # =>  '2023-02-24 04:05:06'
selected_peep.maker_id # =>  '1'

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