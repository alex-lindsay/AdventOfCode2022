require "test/unit"
require_relative "day04"

class TestDay04 < Test::Unit::TestCase
 
  def test_day04_1
    sample = """2-4,6-8
    2-3,4-5
    5-7,7-9
    2-8,3-7
    6-6,4-6
    2-6,4-8"""
    day_04 = Day04.new(sample)
    # p day_04.teams
    # p day_04.team_member_redundancies
    assert_equal(2, day_04.team_member_redundancies.length)
    assert_equal(4, day_04.team_member_overlaps.length)
  end

  def test_day04_a
    data = File.read('day04_data.txt')
    day_04 = Day04.new(data)
    # p day_04.teams
    # p day_04.team_member_redundancies
    assert_equal(450, day_04.team_member_redundancies.length)
    assert_equal(837, day_04.team_member_overlaps.length)
  end

end