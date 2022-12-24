require "test/unit"
require_relative "day14"

class TestDay14 < Test::Unit::TestCase
 
  SAMPLE = """498,4 -> 498,6 -> 496,6
  503,4 -> 502,4 -> 502,9 -> 494,9"""  

  def test_day14_a_sample
    day_14 = Day14.new(SAMPLE, false)
    p day_14.input
    puts day_14.grid_as_string
    p day_14.bounds
    answer = day_14.grains
    assert_equal({:t => 0, :l => 494, :b => 9, :r => 503}, day_14.bounds)
    assert_equal([500, 1], day_14.loc_down([500,0]))
    assert_equal([499, 1], day_14.loc_left([500,0]))
    assert_equal([501, 1], day_14.loc_right([500,0]))

    assert_equal([0, 6], day_14.grid_loc([500,0]))

    assert_equal(".", day_14.grid_val([500,0]))
    assert_equal(".", day_14.grid_val_down([500,0]))
    assert_equal(".", day_14.grid_val_left([500,0]))
    assert_equal(".", day_14.grid_val_right([500,0]))
    assert_equal(24, answer)
  end 

  def test_day14_a
    data = File.read('day14_data.txt')
    day_14 = Day14.new(data, false)
    puts day_14.grid_as_string
    assert_equal(885, day_14.grains)
  end

  def test_day14_b_sample
    day_14 = Day14.new(SAMPLE, false, true)
    puts day_14.grid_as_string
    puts day_14.bounds
    answer = day_14.grains
    assert_equal(93, answer)
  end

  def test_day14_b
    data = File.read('day14_data.txt')
    day_14 = Day14.new(data, false, true)
    answer = day_14.grains
    assert_equal(28691, answer)
  end

end