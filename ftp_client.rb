#!/usr/bin/ruby
# encoding: UTF-8
#
require 'net/ftp'

# argument is user@url:password for tutorial
v2 = ARGV[0].split(':')
v1 = v2[0].split('@')
# Set these 3 variables
ftp_user = v1[0]
ftp_url  = v1[1]
ftp_pass = v2[1]

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
