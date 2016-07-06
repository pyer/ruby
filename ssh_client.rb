#!/usr/bin/ruby
# encoding: UTF-8
#
require 'net/ssh'

# arguments are 'user@host password port' for this tutorial
user, host = ARGV[0].split('@')
password = ARGV[1]
if ARGV[2].nil?
  port =  22 # optional if port = 22
else
  port = ARGV[2]
end

puts "User     = #{user}"
puts "Host     = #{host}"
puts "Password = #{password}"
puts "Port     = #{port}"

begin
  session = Net::SSH.start(host, user, password: password, port: port)
  result = session.exec!('ls -l')
  puts result
  session.close
rescue Net::SSH::AuthenticationFailed
  puts 'ERROR: Authentication failed'
end

puts '--- with block'
begin
  Net::SSH.start(host, user, password: password, port: port) do |ssh|
    result = ssh.exec!('ls -l')
    puts result
  end
rescue Net::SSH::AuthenticationFailed
  puts 'ERROR: Authentication failed'
end

puts '--- with known certificate'
begin
  Net::SSH.start(host, user, port: port) do |ssh|
    result = ssh.exec!('ls -l')
    puts result
  end
rescue Net::SSH::AuthenticationFailed
  puts 'ERROR: Authentication failed'
end
