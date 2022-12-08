require "test/unit"
require_relative "day07"

class TestDay07 < Test::Unit::TestCase
 
  def test_day07_1
    sample = """$ cd /
      $ ls
      dir a
      14848514 b.txt
      8504156 c.dat
      dir d
      $ cd a
      $ ls
      dir e
      29116 f
      2557 g
      62596 h.lst
      $ cd e
      $ ls
      584 i
      $ cd ..
      $ cd ..
      $ cd d
      $ ls
      4060174 j
      8033020 d.log
      5626152 d.ext
      7214296 k"""
    day_07 = Day07.new(sample)
    # day_07.root_dir.dump
    day_07.root_dir.update_size
    day_07.root_dir.dump
    small_dirs = day_07.root_dir.flattened.filter(&:is_dir?).filter {|item| item.size <= 100000 }
    total_size = small_dirs.reduce(0) {|acc, item| acc+item.size}
    assert_equal(95437, total_size)
    
    total_size = 70000000
    available_required = 30000000
    total_used = day_07.root_dir.size
    available = total_size - total_used
    total_needed = available_required - available
    candidate_dirs = day_07.root_dir.flattened.filter(&:is_dir?).filter {|item| item.size >= total_needed }
    best_candidate = candidate_dirs.reduce {|acc, item| (acc.size < item.size) ? acc : item}
    assert_equal(24933642, best_candidate.size)
  end

  def test_day07_a
    data = File.read('day07_data.txt')
    day_07 = Day07.new(data)
    day_07.root_dir.update_size
    day_07.root_dir.dump
    small_dirs = day_07.root_dir.flattened.filter(&:is_dir?).filter {|item| item.size <= 100000 }
    total_size = small_dirs.reduce(0) {|acc, item| acc+item.size}
    assert_equal(1297683, total_size)

    total_size = 70000000
    available_required = 30000000
    total_used = day_07.root_dir.size
    available = total_size - total_used
    total_needed = available_required - available
    candidate_dirs = day_07.root_dir.flattened.filter(&:is_dir?).filter {|item| item.size >= total_needed }
    best_candidate = candidate_dirs.reduce {|acc, item| (acc.size < item.size) ? acc : item}
    assert_equal(5756764, best_candidate.size)
  end
end