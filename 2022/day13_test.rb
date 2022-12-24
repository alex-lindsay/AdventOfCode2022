require "test/unit"
require_relative "day13"

class TestDay13 < Test::Unit::TestCase
 
  SAMPLE = """[1,1,3,1,1]
  [1,1,5,1,1]
  
  [[1],[2,3,4]]
  [[1],4]
  
  [9]
  [[8,7,6]]
  
  [[4,4],4,4]
  [[4,4],4,4,4]
  
  [7,7,7,7]
  [7,7,7]
  
  []
  [3]
  
  [[[]]]
  [[]]
  
  [1,[2,[3,[4,[5,6,7]]]],8,9]
  [1,[2,[3,[4,[5,6,0]]]],8,9]"""

  SAMPLE_WITH_DIVIDERS_SORTED = [
    [],
    [[]],
    [[[]]],
    [1,1,3,1,1],
    [1,1,5,1,1],
    [[1],[2,3,4]],
    [1,[2,[3,[4,[5,6,0]]]],8,9],
    [1,[2,[3,[4,[5,6,7]]]],8,9],
    [[1],4],
    [[2]],
    [3],
    [[4,4],4,4],
    [[4,4],4,4,4],
    [[6]],
    [7,7,7],
    [7,7,7,7],
    [[8,7,6]],
    [9],
  ]

  TEST_A = """[[[[10]],1,5,9,2],[],[7,8,[3,10,6,10]],[3],[[],[1,2,[0,2,6],[10,6]],5]]
  [[10,5,[9,[0,9,3,10,2]],8,6],[2,7,[[2,5],2,[2,4,4,9,3],4]]]"""
  
  TEST_B = """[[5,8,[[10,1,5],[1,2],6,[8,9,9,6,0],[2,0,9,3,7]],9,8],[[],9,[2]]]
  [[[5,[],[9,5,10,3,4]],4,2],[],[[1,[9,4],[0]],9,3]]"""
  
  TEST_C = """[[[10,8,4,[8,7,9,3,4]],[3,5,[0,10,6,8]]]]
  [[[[10],[1,9,1,5]],[[5,8],[3,4],[9,3,0]],3],[9,[],9,9,5],[9,[3]],[]]"""  

  def test_day13_1
    day_13 = Day13.new(SAMPLE, true)
    result = day_13.comparisons
    p result
    assert_equal([true, true, false, true, false, true, false, false], result)
    answer = result.each_with_index.reduce(0) { |a, (v, i)| v ? (a + i + 1) : a }
    assert_equal(13, answer)
  end 

  def test_day13_1a
    day_13 = Day13.new(TEST_A, true)
    result = day_13.comparisons
    p result
    assert_equal([nil], result)
  end 

  def test_day13_1b
    day_13 = Day13.new(TEST_B, true)
    result = day_13.comparisons
    p result
    assert_equal([nil], result)
  end 

  def test_day13_1c
    day_13 = Day13.new(TEST_C, true)
    result = day_13.comparisons
    p result
    assert_equal([nil], result)
  end 

  def test_day13_a
    data = File.read('day13_data.txt')
    day_13 = Day13.new(data, true)
    result = day_13.comparisons
    output = (day_13.input.map {|v| v.map { |v2| v2.to_s[0..10]} }).zip result
    output.each { |v| p v }

    # assert_equal([true, true, false, true, false, true, false, false], result)
    answer = result.each_with_index.reduce(0) { |a, (v, i)| v ? (a + i + 1) : a }
    assert_equal(6656, answer)
  end

  def test_day13_b_sample
    day_13 = Day13.new(SAMPLE)
    result = day_13.sort([[[2]],[[6]]])
    result.each_with_index { |v, i| p [i, v] }
    p result.length
    assert_equal(SAMPLE_WITH_DIVIDERS_SORTED, result)
    div1 = result.index([[2]])+1
    div2 = result.index([[6]])+1
    assert_equal(140, div1*div2)
  end

  def test_day13_b
    data = File.read('day13_data.txt')
    day_13 = Day13.new(data, false)
    result = day_13.sort([[[2]],[[6]]])
    result.each { |v| p v }
    p result.length
    div1 = result.index([[2]])+1
    div2 = result.index([[6]])+1
    assert_equal(19716, div1*div2)
  end

end