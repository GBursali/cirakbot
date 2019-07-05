# Handles basic database stuff.
require 'sqlite3'

# Basic methods for Database
class Database
  def initialize(filename)
    @db = SQLite3::Database.open filename
  rescue SQLite3::Exception => exception
    puts exception
    @db.close if @db
  end

  def new_table(table_name, query)
    @db.execute "Create Table IF NOT EXISTS #{table_name}(#{query})"
  end

  def update(table_name, query, setter)
    @db.execute "Update #{table_name} SET #{setter} WHERE #{query}"
  end

  def delete(table_name, query)
    text = "Delete from #{table_name}"
    text += "where #{query}" unless query == ''
    @db.execute text
  end

  def read(table_name)
    @db.execute "SELECT * FROM #{table_name}"
  end

  def write(table_name, data)
    @db.execute "Insert Into #{table_name} VALUES(#{data})"
  end
end
