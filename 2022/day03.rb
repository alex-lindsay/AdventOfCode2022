class Day03
  attr_reader :rucksacks, :overlaps

  def initialize(data)
    load(data) if data
  end

  def priority(letter)
    (letter.ord > 96) ? (letter.ord - 96) : (letter.ord - 38)
  end

  # assumes two compartments per rucksack
  # assumes they are of equal size
  def load(data)
    @rucksacks = []
    @overlaps = []
    data.split("\n").each do |rucksack|
      @rucksacks << rucksack.strip
    end
    # p @rucksacks
    update_overlaps!
  end

  def update_overlaps!
    @overlaps = @rucksacks.map do |rucksack| 
      len = rucksack.length / 2
      rucksack[0...len].split("").intersection(rucksack[len..-1].split(""))
    end
    # p @overlaps
  end

  def priority_sum
    @overlaps.reduce(0) {|total, overlap| total + overlap.reduce(0) { |subtotal, char| subtotal + priority(char) } }
  end

  def groups(n)
    @rucksacks.each_slice(n)
  end

  def group_overlaps(n)
    grps = groups(n)
    # p grps
    grps.map do |group|
      group.reduce(group[0].split("")) { |overlap, rucksack| overlap.intersection rucksack.split("") }
    end
  end

  def group_overlap_priority_sum(n)
    grp_over = group_overlaps(n)
    # p grp_over
    grp_over.reduce(0) {|total, overlap| total + overlap.reduce(0) { |subtotal, char| subtotal + priority(char) } }
  end

end

