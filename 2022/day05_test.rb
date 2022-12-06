require "test/unit"
require_relative "day05"

class TestDay05 < Test::Unit::TestCase
 
  def test_day05_1
    sample = """    [D]    
[N] [C]    
[Z] [M] [P]
  1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2"""
    day_05 = Day05.new(sample)
    p day_05.to_str
    # p day_05.moves
    day_05.perform_moves!
    # p day_05.stacks
    # p day_05.stack_tops
    assert_equal("CMZ", day_05.stack_tops)

    day_05b = Day05.new(sample)
    day_05b.perform_moves_9001!
    assert_equal("MCD", day_05b.stack_tops)
  end

  def test_day05_a
    data = File.read('day05_data.txt')
    day_05 = Day05.new(data)
    # p day_05.to_str
    day_05.perform_moves!
    # p day_05.stacks
    assert_equal("LJSVLTWQM", day_05.stack_tops)
  end

  def test_day05_b
    data = File.read('day05_data.txt')
    day_05 = Day05.new(data)
    # p day_05.to_str
    day_05.perform_moves_9001!
    # p day_05.stacks
    assert_equal("BRQWDBBJM", day_05.stack_tops)
  end
end