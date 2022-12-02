require "test/unit"
require_relative "day01"

class TestDay01 < Test::Unit::TestCase
 
  def test_day01_1
    sample = """1000
    2000
    3000
    
    4000
    
    5000
    6000
    
    7000
    8000
    9000
    
    10000"""
    day_01 = Day01.new(sample)
    # puts day_01.most_food_carried
    assert_equal(24000, day_01.most_food_carried)
    puts day_01.top_n_total(3)
    assert_equal(45000, day_01.top_n_total(3))
  end

  def test_day01_a
    data = File.read('day01_data.txt')
    day_01 = Day01.new(data)
    assert_equal(68292, day_01.most_food_carried)
  end

  def test_day01_b
    data = File.read('day01_data.txt')
    day_01 = Day01.new(data)
    assert_equal(0, day_01.top_n_total(3))
  end

end