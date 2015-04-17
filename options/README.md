Options
=======

Options is a option parser with a simple syntax and friendly API.
Original idea is taken from Slop option parser (https://github.com/leejarvis/slop)
Many thanks to Lee Jarvis.

Usage
-----

Options parse four words:
run
: run block is executed during options parsing.
banner
: banner add text to the help message.
: Help message is displayed with implicit option -h|--help|?|help.
option (alias on)
: Linux style options are declared with option (-o|--option).
: Short option is the first letter of the long option name.
command (alias cmd)
: Git style sub-commands are declared with command.

```ruby
opts = Options.parse do
  banner 'Some help text'
  option 'name=',     'Your name'
  option 'password=', 'Your password'
  option 'verbose',   'Enable verbose mode'
end

# if ARGV is `--name Lee -v`
opts.verbose?  #=> true
opts.password? #=> false
opts.other?    #=> false
opts.name?     #=> true
opts[:name]    #=> 'Lee'
opts.to_hash   #=> {:name=>"Lee", :password=>nil, :verbose=>true}

```

Installation
------------
    rake install
    (May or will be "gem install options")

Test
----
    rake test

Printing Help
-------------

Options attempts to build a good looking help string to print to your users.
You can get this string by calling `opts.help` method.
The options '-h', '--help' and '?' are available and show this help.

Example:

```ruby
# example.rb
require 'options'
opts = Options.parse do
  banner 'banner'
  on :foo, 'Enable foo mode'
end
```

ruby example.rb --help
("ruby example.rb -h" or "ruby example.rb ?" give the same result)
 
```
Usage: example.rb [options]
  banner
Options:
    -f|--foo       : Enable foo mode

```

