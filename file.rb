# encoding: UTF-8
require 'minitest/autorun'

class TestFile < Minitest::Test
  TXT_FILE = 'file.txt'
  TMP_FILE = 'file.tmp'
  CONTENT = "some data\nand other\n"

  def setup
    File.write(TXT_FILE, CONTENT)
  end

  def teardown
    File.delete(TXT_FILE)
  end

  def test_write1
    File.write(TMP_FILE, CONTENT)
    assert_equal(File.exist?(TMP_FILE), true)
    assert_equal(File.read(TMP_FILE).to_s, CONTENT)
    File.delete(TMP_FILE)
  end

  def test_write2
    File.open(TMP_FILE, "w") do |f|
      f.write CONTENT
      f.close
    end
    assert_equal(File.exist?(TMP_FILE), true)
    assert_equal(File.read(TMP_FILE).to_s, CONTENT)
    File.delete(TMP_FILE)
  end

  def test_append
    File.write(TMP_FILE, CONTENT)
    File.open(TMP_FILE, "a") do |f|
      f.puts 'more data'
      f.close
    end
    assert_equal(File.exist?(TMP_FILE), true)
    assert_equal(File.read(TMP_FILE).to_s, CONTENT + "more data\n")
    File.delete(TMP_FILE)
  end

  def test_read1
    content = ''
    File.open(TXT_FILE, "r") do |f|
      content = f.read
      f.close
    end
    assert_equal(content, CONTENT)
  end

  def test_read2
    content = ''
    File.open(TXT_FILE, "r") do |f|
      # read the first line only
      content = f.gets
      f.close
    end
    assert_equal(content, "some data\n")
  end

  def test_read3
    content = ''
    f = File.new(TXT_FILE, "r")
    while (line = f.gets)
      content = content + line
    end
    f.close
    assert_equal(content, CONTENT)
  end

  def test_read4
    content = ''
    File.open(TXT_FILE, "r").each_line do |line|
      content = content + line
    end
    assert_equal(content, CONTENT)
  end

  def test_read5
    content = ''
    File.readlines(TXT_FILE).each do |line|
      content = content + line
    end
    assert_equal(content, CONTENT)
  end

  def test_read6
    content = ''
    # for short file
    content = File.read(TXT_FILE)
    assert_equal(content, CONTENT)
  end

  def test_read_with_index
    numbers = ''
    content = ''
    File.foreach(TXT_FILE).with_index do |line, line_num|
      numbers = numbers + "#{line_num} "
      content = content + line
    end
    assert_equal(numbers, '0 1 ')
    assert_equal(content, CONTENT)
  end

  def test_io_readlines
    content = IO.readlines(TXT_FILE)
    assert_equal(content, ["some data\n", "and other\n"])
  end
end

