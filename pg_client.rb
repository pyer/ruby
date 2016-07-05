#!/usr/bin/ruby
# encoding: UTF-8
#
require 'pg'

dbname='db_test'

connection = PGconn.new(:dbname => "postgres", :user => 'postgres', :password => 'postgres', :host => 'localhost', :port => '5432')
result = connection.query('SELECT datname as "Name", pg_catalog.pg_get_userbyid(datdba) as "Owner" FROM pg_catalog.pg_database ORDER BY datname;')
connection.finish

result.each do |row|
  puts "Database #{row['Name']} is owned by #{row['Owner']}"
end

puts "\nQueries:"
connection = PGconn.new(:user => 'postgres')
result = connection.query("select datname, query, state from pg_stat_activity;")
result.each do |row|
  row.each do |column|
   p column
  end
end
connection.finish
