#!/usr/bin/ruby

require 'find'

Find.find('/proc/fs/') do |path|
    if FileTest.directory?(path)
      puts "Dir  : " + path
      next
    else
      puts "File : " + path
    end
end
