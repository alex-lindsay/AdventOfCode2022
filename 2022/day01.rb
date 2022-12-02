class Day01
  attr_accessor :elves

  def initialize(data)
    load(data) if data
  end

  def load(data)
    @elves = []
    current = {food:[], total:0}
    data.split("\n").each do |food_row|
      food_text = food_row.strip
      if food_text.empty? then
        @elves << current
        current = {food:[], total:0}
      else
        food_value = food_text.to_i
        current[:food] << food_value
        current[:total] += food_value
      end
    end
    @elves << current
    # p @elves
  end

  def most_food_carried
    @elves.reduce(0) { |acc, elf| [acc, elf[:total]].max }
  end

  def top_n_total(n)
    @elves.sort { |a, b| b[:total] <=> a[:total] }[0...n].reduce(0) { |acc, elf| acc + elf[:total] }
  end

end
