require "test/unit"
require_relative "day11"

def top_n_monkeys(monkeys, n) = (monkeys.values.sort { |l,r| -l.examinations <=> -r.examinations })[0...n]


class TestDay11 < Test::Unit::TestCase
 
  SAMPLE = """Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3
  
  Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0
  
  Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3
  
  Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1"""

  def test_day11_1
    day_11 = Day11.new(SAMPLE)
    20.times do |i|
      # puts "Round %s" % (i+1).to_s if [1, 20, 50].include?(i+1)
      day_11.do_monkey_business
      # day_11.dump_examinations if [1, 20].include?(i+1)
    end
    # puts "At finish:"
    # day_11.dump_examinations
    top_examinations = top_n_monkeys(day_11.monkeys, 2).map(&:examinations)
    # p top_examinations
    monkey_business_score = top_examinations.reduce { |acc, val| acc * val }
    assert_equal(10605, monkey_business_score)
  end 

  def test_day11_2
    day_11 = Day11.new(SAMPLE, false, false)
    10000.times do |i|
      # puts "Round %s" % (i+1).to_s if [1, 20, 5, 1000, 2000, 3000, 10000].include?(i+1)
      day_11.do_monkey_business
      # day_11.dump_examinations if [1, 20, 5, 1000, 2000, 3000, 10000].include?(i+1)
    end
    # puts "At finish:"
    # day_11.dump_examinations
    top_examinations = top_n_monkeys(day_11.monkeys, 2).map(&:examinations)
    # p top_examinations
    monkey_business_score = top_examinations.reduce { |acc, val| acc * val }
    assert_equal(2713310158, monkey_business_score)
  end 

  def test_day11_a
    data = File.read('day11_data.txt')
    day_11 = Day11.new(data)
    day_11.dump_items
    20.times do |i|
      day_11.do_monkey_business
      # puts "Round %s" % i.to_s
      # day_11.dump_items
      # day_11.dump_examinations
      # puts
    end
    # puts "At finish:"
    # day_11.dump_examinations
    top_examinations = top_n_monkeys(day_11.monkeys, 2).map(&:examinations)
    # p top_examinations
    monkey_business_score = top_examinations.reduce { |acc, val| acc * val }
    assert_equal(101436, monkey_business_score)
  end

  def test_day11_b
    data = File.read('day11_data.txt')
    day_11 = Day11.new(data, false)
    day_11.dump_items
    10000.times do |i|
      day_11.do_monkey_business
      puts "Round %s" % (i+1).to_s if [1, 20, 5, 1000, 2000, 3000, 10000].include?(i+1)
      # day_11.dump_items
      day_11.dump_examinations if [1, 20, 5, 1000, 2000, 3000, 10000].include?(i+1)
    end
    puts "At finish:"
    day_11.dump_examinations
    top_examinations = top_n_monkeys(day_11.monkeys, 2).map(&:examinations)
    # p top_examinations
    monkey_business_score = top_examinations.reduce { |acc, val| acc * val }
    assert_equal(19754471646, monkey_business_score)
  end

end