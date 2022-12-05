class Day04
  attr_reader :teams

  def initialize(data)
    load(data) if data
  end

  def load(data)
    @teams = data.split("\n").map do |team|
      ((team.strip).split(',').map {|elf| elf.split("-").map {|v| v.to_i} })
    end
  end

  def team_member_redundancies
    @teams.filter do |team|
      ((team[0][0] <= team[1][0]) and (team[0][1] >= team[1][1])) or 
      ((team[1][0] <= team[0][0]) and (team[1][1] >= team[0][1]))
    end
  end

  def team_member_overlaps
    @teams.filter do |team|
      ((team[0][0] <= team[1][1]) and (team[0][1] >= team[1][0]))
    end
  end
end
