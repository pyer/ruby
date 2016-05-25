#!/usr/bin/ruby
# encoding: UTF-8
#
require 'net/ssh'

# Set these 4 variables
host     = '?'
user     = '?'
password = '???'
port     =  22 # optional if port = 22

begin
  session = Net::SSH.start(host, user, :password => password, :port => port)
  result = session.exec!("ls -l")
  puts result
  session.close
rescue Net::SSH::AuthenticationFailed
  puts 'ERROR: Authentication failed'
end

puts '--- with block'
begin
  Net::SSH.start(host, user, :password => password, :port => port) do |ssh|
    result = ssh.exec!("ls -l")
    puts result
  end
rescue Net::SSH::AuthenticationFailed
  puts 'ERROR: Authentication failed'
end

puts '--- with known certificate'
begin
  Net::SSH.start(host, user, :port => port) do |ssh|
    result = ssh.exec!("ls -l")
    puts result
  end
rescue Net::SSH::AuthenticationFailed
  puts 'ERROR: Authentication failed'
end

