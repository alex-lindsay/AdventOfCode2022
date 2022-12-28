require "test/unit"
require_relative "day15"

class TestDay15 < Test::Unit::TestCase
 
  SAMPLE = """Sensor at x=2, y=18: closest beacon is at x=-2, y=15
  Sensor at x=9, y=16: closest beacon is at x=10, y=16
  Sensor at x=13, y=2: closest beacon is at x=15, y=3
  Sensor at x=12, y=14: closest beacon is at x=10, y=16
  Sensor at x=10, y=20: closest beacon is at x=10, y=16
  Sensor at x=14, y=17: closest beacon is at x=10, y=16
  Sensor at x=8, y=7: closest beacon is at x=2, y=10
  Sensor at x=2, y=0: closest beacon is at x=2, y=10
  Sensor at x=0, y=11: closest beacon is at x=2, y=10
  Sensor at x=20, y=14: closest beacon is at x=25, y=17
  Sensor at x=17, y=20: closest beacon is at x=21, y=22
  Sensor at x=16, y=7: closest beacon is at x=15, y=3
  Sensor at x=14, y=3: closest beacon is at x=15, y=3
  Sensor at x=20, y=1: closest beacon is at x=15, y=3"""

  PARSED_SAMPLE = [[2, 18, -2, 15, 7], [9, 16, 10, 16, 1], [13, 2, 15, 3, 3], 
  [12, 14, 10, 16, 4], [10, 20, 10, 16, 4], [14, 17, 10, 16, 5], [8, 7, 2, 10, 9], 
  [2, 0, 2, 10, 10], [0, 11, 2, 10, 3], [20, 14, 25, 17, 8], [17, 20, 21, 22, 6], 
  [16, 7, 15, 3, 5], [14, 3, 15, 3, 1], [20, 1, 15, 3, 7]]

  # def test_day15_a_sample
  #   day_15 = Day15.new(SAMPLE, false)

  #   assert_equal(PARSED_SAMPLE, day_15.input)
  #   assert_equal({:t => -10, :l => -8, :b => 26, :r => 28}, day_15.range)

  #   assert_equal(26, day_15.beacon_clear_spaces_in_row(10))
  # end 

  # def test_day15_a
  #   data = File.read('day15_data.txt')
  #   day_15 = Day15.new(data, false)
  #   assert_equal(5878678, day_15.beacon_clear_spaces_in_row(2000000))
  # end

  def test_day15_b_sample
    day_15 = Day15.new(SAMPLE, false, 20)
    answer = day_15.beacon_frequency
    assert_equal(56000011, answer)
  end

  def test_day15_b
    data = File.read('day15_data.txt')
    day_15 = Day15.new(data, false)
    answer = day_15.beacon_frequency
    assert_equal(0, answer)
  end

end