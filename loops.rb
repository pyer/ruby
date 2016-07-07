# encoding: UTF-8
require 'minitest/autorun'

# Ruby loop statements tutorial
class TestLoop < Minitest::Test
  def test_while
    r = ''
    i = 0
    while i < 3
      r += " #{i}"
      i += 1
    end
    assert_equal(r, ' 0 1 2')
  end

  def test_do_while
    r = ''
    i = 0
    # Rubocop: Use Kernel#loop with break rather than begin/end/until(or while).
    begin
      r += " #{i}"
      i += 1
    end while i < 3
    assert_equal(r, ' 0 1 2')
  end

  def test_until
    r = ''
    i = 0
    until i > 2
      r += " #{i}"
      i += 1
    end
    assert_equal(r, ' 0 1 2')
  end

  def test_do_until
    r = ''
    i = 0
    # Rubocop: Use Kernel#loop with break rather than begin/end/until(or while).
    begin
      r += " #{i}"
      i += 1
    end until i > 2
    assert_equal(r, ' 0 1 2')
  end

  def test_for
    r = ''
    # Rubocop: Prefer each over for.
    for i in (0..2)
      r += " #{i}"
    end
    assert_equal(r, ' 0 1 2')
  end

  def test_times
    r = ''
    3.times do |i|
      r += " #{i}"
    end
    assert_equal(r, ' 0 1 2')
  end

  def test_each
    r = ''
    (0..2).each do |i|
      r += " #{i}"
    end
    assert_equal(r, ' 0 1 2')
  end

  def test_break
    r = ''
    (0..7).each do |i|
      break if i > 2
      r += " #{i}"
    end
    assert_equal(r, ' 0 1 2')
  end

  def test_next
    r = ''
    (0..3).each do |i|
      next if i == 1
      r += " #{i}"
    end
    assert_equal(r, ' 0 2 3')
  end

  def test_redo
    r = ''
    (0..1).each do |i|
      r += " #{i}"
      redo if r.length == 4
    end
    assert_equal(r, ' 0 1 1')
  end
end
