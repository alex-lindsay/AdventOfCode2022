require "test/unit"
require_relative "day03"

class TestDay03 < Test::Unit::TestCase
 
  def test_day03_1
    sample = """vJrwpWtwJgWrhcsFMMfFFhFp
    jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
    PmmdzqPrVvPwwTWBwg
    wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
    ttgJtRGJQctTZtZT
    CrZsJsPPZsGzwwsLwLmpwMDw"""
    day_03 = Day03.new(sample)
    assert_equal(157, day_03.priority_sum)
    assert_equal(70, day_03.group_overlap_priority_sum(3))
  end

  def test_day03_a
    data = File.read('day03_data.txt')
    day_03 = Day03.new(data)
    assert_equal(7597, day_03.priority_sum)
    assert_equal(2607, day_03.group_overlap_priority_sum(3))
  end

end