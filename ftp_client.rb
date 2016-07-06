#!/usr/bin/ruby
# encoding: UTF-8
#
require 'net/ftp'

# arguments are 'user@url password' for this tutorial
ftp_user, ftp_url = ARGV[0].split('@')
ftp_pass = ARGV[1]

puts "User     = #{ftp_user}"
puts "URL      = #{ftp_url}"
puts "Password = #{ftp_pass}"

ftp = Net::FTP.open(ftp_url)
ftp.login(ftp_user, ftp_pass)
# List files in current directory
puts ftp.list
# The following are the most useful FTP commands
#  binary
#  get
#  getbinaryfile
#  gettextfile
#  put
#  putbinaryfile
#  puttextfile
#  chdir
#  list
#  nlst
#  size
#  rename
#  delete
ftp.close
