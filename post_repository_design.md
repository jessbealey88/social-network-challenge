## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content, views, user_account_id) VALUES ('post_1', 'some text about stuff', '10', '1');
INSERT INTO posts (title, content, views, user_account_id) VALUES ('post_2', 'some celebrity gossip', '5', '2');
INSERT INTO posts (title, content, views, user_account_id) VALUES ('post_2', 'Happy birthday message to a friend', '12', '1');


```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: posts

# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: posts

# Model class 
# (in lib/post.rb)

class Post

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :content, :views, :user_account_id
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
# Table name: user_accounts

# Repository class
# (in lib/student_repository.rb)

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, content, views, user_account_id FROM posts;

    # Returns an array of post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, content, views, user_account_id FROM posts WHERE id = $1;

    # Returns a single post object.
  end

  def create(post)
    # Executes the SQL query:
    # INSERT INTO posts (title, content, views, user_account_id) VALUES($1, $2, $3, $4);
  end

  def delete(post)
  # Executes the SQL query:
  # DELETE FROM posts WHERE id = $1;
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all posts

repo = PostRepository.new

posts = repo.all

posts.length # =>  3

posts[0].id # =>  '1'
posts[0].title # => 'post_1'
posts[0].content # => 'some text about stuff',
posts[0].views # =>  '10'
posts[0].user_account_id # =>  '1'

# 2
# Get a single user account

repo = PostRepository.new

post = repo.find(1)

post.id # => '1'
post.title # => 'post_1'
post.content # => 'some text about stuff',
post.views # =>  '10'
post.user_account_id # =>  '1'



#3
#Create a post
repo = PostRepository.new
new_post = Post.new
new_post.title ='post_4'
new_post.content = 'An important announcement'
new_post.views = '9'
new_post.user_account_id = '2'
repo.create(new_post)
expect(repo.all).to include(
    have_attributes(
      title: new_post.title,
      content: new_post.content,
      views: new_post.views,
      user_account_id: new_post.user_account_id))

#4
#Delete a post
repo = PostRepository.new
repo.delete(1)
post = repo.find(1)
# Expect user to not exist


```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/user_account_repository_spec.rb

def reset_user_accounts_table
  seed_sql = File.read('spec/seeds_socialnetwork.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe UserAccountRepository do
  before(:each) do 
    reset_user_accounts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

