require "test/unit"
require_relative "day10"

def test_vals(day) = [20,60,100,140,180,220].map { |i| day.history[i-1] }
def test_strengths(day) = [20,60,100,140,180,220].map { |i| day.signal_strength i }
def test_total(day) = test_strengths(day).reduce { |acc, val| acc + val }

class TestDay10 < Test::Unit::TestCase
 
  def test_day10_1
    sample = """noop
    addx 3
    addx -5"""
    day_10 = Day10.new(sample)
    # p day_10.history
    # assert_equal(13, day_10.tail_visited.uniq.length)
    # assert_equal(1, day_10.tail2_visited.uniq.length)
  end 

  def test_day10_2
    sample = """addx 15
    addx -11
    addx 6
    addx -3
    addx 5
    addx -1
    addx -8
    addx 13
    addx 4
    noop
    addx -1
    addx 5
    addx -1
    addx 5
    addx -1
    addx 5
    addx -1
    addx 5
    addx -1
    addx -35
    addx 1
    addx 24
    addx -19
    addx 1
    addx 16
    addx -11
    noop
    noop
    addx 21
    addx -15
    noop
    noop
    addx -3
    addx 9
    addx 1
    addx -3
    addx 8
    addx 1
    addx 5
    noop
    noop
    noop
    noop
    noop
    addx -36
    noop
    addx 1
    addx 7
    noop
    noop
    noop
    addx 2
    addx 6
    noop
    noop
    noop
    noop
    noop
    addx 1
    noop
    noop
    addx 7
    addx 1
    noop
    addx -13
    addx 13
    addx 7
    noop
    addx 1
    addx -33
    noop
    noop
    noop
    addx 2
    noop
    noop
    noop
    addx 8
    noop
    addx -1
    addx 2
    addx 1
    noop
    addx 17
    addx -9
    addx 1
    addx 1
    addx -3
    addx 11
    noop
    noop
    addx 1
    noop
    addx 1
    noop
    noop
    addx -13
    addx -19
    addx 1
    addx 3
    addx 26
    addx -30
    addx 12
    addx -1
    addx 3
    addx 1
    noop
    noop
    noop
    addx -9
    addx 18
    addx 1
    addx 2
    noop
    noop
    addx 9
    noop
    noop
    noop
    addx -1
    addx 2
    addx -37
    addx 1
    addx 3
    noop
    addx 15
    addx -21
    addx 22
    addx -6
    addx 1
    noop
    addx 2
    addx 1
    noop
    addx -10
    noop
    noop
    addx 20
    addx 1
    addx 2
    addx 2
    addx -6
    addx -11
    noop
    noop
    noop"""
    day_10 = Day10.new(sample)
    # p day_10.history
    # p day_10.history[219..220]
    assert_equal([21,19,18,21,16,18], test_vals(day_10))
    assert_equal([420,1140,1800,2940,2880,3960], test_strengths(day_10))
    assert_equal(13140, test_total(day_10))
    puts day_10.draw_output
  end 

  def test_day10_a
    data = File.read('day10_data.txt')
    day_10 = Day10.new(data)
    assert_equal(13520, test_total(day_10))
    puts day_10.draw_output
  end
end