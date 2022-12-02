require "test/unit"
require_relative "day02"

class TestDay02 < Test::Unit::TestCase
 
  def test_day02_1
    sample = """A Y
    B X
    C Z"""
    day_02 = Day02.new(sample)
    # puts day_02.most_food_carried
    assert_equal(15, day_02.total_score)
    assert_equal(12, day_02.total_strategy_score)
  end

  def test_day02_a
    data = File.read('day02_data.txt')
    day_02 = Day02.new(data)
    assert_equal(10994, day_02.total_score)
    assert_equal(12526, day_02.total_strategy_score)
  end

end