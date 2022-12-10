require "test/unit"
require_relative "day09"

class TestDay09 < Test::Unit::TestCase
 
  def test_day09_1
    sample = """R 4
    U 4
    L 3
    D 1
    R 4
    D 1
    L 5
    R 2"""
    day_09 = Day09.new(sample)
    # p day_09.motions
    # p day_09.tail_visited
    # p day_09.tail_visited.uniq
    # p ["len", day_09.tail_visited.uniq.length]
    assert_equal(13, day_09.tail_visited.uniq.length)
    assert_equal(1, day_09.tail2_visited.uniq.length)
  end 

  def test_day09_2
    sample = """R 5
    U 8
    L 8
    D 3
    R 17
    D 10
    L 25
    U 20"""
    day_09 = Day09.new(sample)
    # p day_09.motions
    # p day_09.tail_visited
    # p day_09.tail_visited.uniq
    # p day_09.tail_visited.uniq.length
    # assert_equal(13, day_09.tail_visited.uniq.length)
    assert_equal(36, day_09.tail2_visited.uniq.length)
  end 

  def test_day09_a
    data = File.read('day09_data.txt')
    day_09 = Day09.new(data)
    assert_equal(6175, day_09.tail_visited.uniq.length)
    assert_equal(0, day_09.tail2_visited.uniq.length)
  end
end