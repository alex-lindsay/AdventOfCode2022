require "test/unit"
require_relative "day12"

class TestDay12 < Test::Unit::TestCase
 
  SAMPLE = """Sabqponm
  abcryxxl
  accszExk
  acctuvwj
  abdefghi"""

  SAMPLE1 = """Szbqponm
  azcrzzyl
  azzszExk
  acctuvwj
  abdefghi"""



  def test_day12_1
    day_12 = Day12.new(SAMPLE)
    assert_equal("S", day_12.cell([0,0]))
    # assert_equal("E", day_12.cell([5,2]))
    assert_equal(nil, day_12.cell([-1,2]))
    assert_equal(nil, day_12.cell([0,-1]))
    assert_equal(nil, day_12.cell([100,2]))
    assert_equal(nil, day_12.cell([0,100]))
    assert_equal(97, day_12.height([0,0]))
    assert_equal(122, day_12.height([5,2]))
    # p ["successes", day_12.successes, day_12.successes.reduce { |acc,val| (acc.length < val.length) ? acc : val }]
    puts
    p day_12.input
    shortest_path = day_12.shortest_path.length - 1
    p ["shortest_path", shortest_path]
    assert_equal(31, shortest_path)

    starters = (0..SAMPLE.length).filter { |i| ["S", "a"].include? SAMPLE[i] }
    p ["starters", starters]
    lengths = []
    starters.each do |i|
      input = SAMPLE
      input.gsub!("S","a")
      input[i] = "S"
      day_12 = Day12.new(input)
      p day_12.input
      shortest_path = day_12.shortest_path
      p ["shortest_path", shortest_path]
      lengths << day_12.shortest_path.length - 1
    end
    p ["lengths", lengths]
    shortest_path_length = lengths.reduce { |acc, val| (val < acc) ? val : acc }
    assert_equal(29, shortest_path_length)
  end 

  def test_day12_a
    data = File.read('day12_data.txt')
    day_12 = Day12.new(data)
    assert_equal(408, day_12.shortest_path.length - 1)
  end

  def test_day12_b
    data = File.read('day12_data.txt')
    day_12 = Day12.new(data, false)

    starters = (0..data.length).filter { |i| ["S", "a"].include? data[i] }
    p ["starters", starters]
    lengths = []
    n = 0
    starters.each do |i|
      puts "%s: %s / %s" % [i, n, starters.length]
      input = data
      input.gsub!("S","a")
      input[i] = "S"
      day_12 = Day12.new(input)
      # p day_12.input
      shortest_path = day_12.shortest_path
      # p ["shortest_path", shortest_path]
      lengths << day_12.shortest_path.length - 1 if !shortest_path.nil?
      n += 1
    end
    p ["lengths", lengths]
    shortest_path_length = lengths.reduce { |acc, val| (val < acc) ? val : acc }
    assert_equal(399, shortest_path_length)
  end

end