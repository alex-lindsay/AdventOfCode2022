require "test/unit"
require_relative "day06"

class TestDay06 < Test::Unit::TestCase
 
  def test_day06_1
    sample = """mjqjpqmgbljsphdztnvjfqwrcgsmlb"""
    day_06 = Day06.new(sample)
    assert_equal(7, day_06.find_start_of_packet)
    assert_equal(19, day_06.find_start_of_message)
  end

  def test_day06_2
    sample = """bvwbjplbgvbhsrlpgdmjqwftvncz"""
    day_06 = Day06.new(sample)
    assert_equal(5, day_06.find_start_of_packet)
    assert_equal(23, day_06.find_start_of_message)
  end

  def test_day06_3
    sample = """nppdvjthqldpwncqszvftbrmjlhg"""
    day_06 = Day06.new(sample)
    assert_equal(6, day_06.find_start_of_packet)
    assert_equal(23, day_06.find_start_of_message)
  end

  def test_day06_4
    sample = """nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"""
    day_06 = Day06.new(sample)
    assert_equal(10, day_06.find_start_of_packet)
    assert_equal(29, day_06.find_start_of_message)
  end

  def test_day06_5
    sample = """zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"""
    day_06 = Day06.new(sample)
    assert_equal(11, day_06.find_start_of_packet)
    assert_equal(26, day_06.find_start_of_message)
  end

  def test_day06_a
    data = File.read('day06_data.txt')
    day_06 = Day06.new(data)
    assert_equal(1625, day_06.find_start_of_packet)
    assert_equal(2250, day_06.find_start_of_message)
  end
end