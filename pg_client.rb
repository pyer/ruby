#!/usr/bin/ruby
# encoding: UTF-8
#
require 'pg'

connection = PG::Connection.new(dbname: 'postgres', user: 'postgres', password: 'postgres',
                                host: 'localhost', port: '5432')
result = connection.query('SELECT datname as "Name", pg_catalog.pg_get_userbyid(datdba) as "Owner"
                           FROM pg_catalog.pg_database ORDER BY datname;')
result.each do |row|
  puts "Database #{row['Name']} is owned by #{row['Owner']}"
end
connection.finish

puts "\nQueries:"
connection = PG::Connection.new(user: 'postgres')
result = connection.query('select datname, query, state from pg_stat_activity;')
result.each do |row|
  row.each do |column|
    p column
  end
end
connection.finish
