
require 'net/ftp'

ftp_url  = '???'
ftp_user = '?'
ftp_pass = '?'

# Set these 3 variables
puts "User     = #{ftp_user}"
puts "Password = #{ftp_pass}"
puts "URL      = #{ftp_url}"

ftp=Net::FTP.open(ftp_url)
ftp.login(user = ftp_user, passwd = ftp_pass)
# List files in current directory
puts ftp.list
  # The following are the most useful FTP commands
  # - #binary
  # - #get
  # - #getbinaryfile
  # - #gettextfile
  # - #put
  # - #putbinaryfile
  # - #puttextfile
  # - #chdir
  # - #list
  # - #nlst
  # - #size
  # - #rename
  # - #delete
  #
ftp.close
