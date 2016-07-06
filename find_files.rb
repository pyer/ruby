# encoding: UTF-8
require 'find'
require 'minitest/autorun'

# Find methods tutorial
class TestFind < Minitest::Test
  def test_find
    Find.find('/proc/fs/') do |path|
      if FileTest.directory?(path)
        Find.prune if path.start_with?('/proc/fs/au')
        puts 'Dir  : ' + path
        next
      else
        puts 'File : ' + path
      end
    end
  end
end
