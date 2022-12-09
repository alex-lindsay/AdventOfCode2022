require "test/unit"
require_relative "day08"

class TestDay08 < Test::Unit::TestCase
 
  def test_day08_1
    sample = """30373
    25512
    65332
    33549
    35390"""
    day_08 = Day08.new(sample)
    puts day_08.dump
    puts day_08.dump_visibility
    assert_equal(21, day_08.visible_trees)
    p day_08.scenic
    assert_equal(8, day_08.max_scenic_score)
  end 

  def test_day08_a
    data = File.read('day08_data.txt')
    day_08 = Day08.new(data)
    assert_equal(1823, day_08.visible_trees)
    assert_equal(8, day_08.max_scenic_score)
  end
end