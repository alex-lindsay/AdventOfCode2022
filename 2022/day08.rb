class Day08
  attr_reader :trees, :visibility, :scenic

  def initialize(data)
    load(data) if data
  end

  def load(data)
    @trees = data.split("\n").map {|row| row.strip.split("").map(&:to_i)}
    update_visibility
    update_scenic
  end

  def dump = (@trees.map { |r| r.join(" ") }).join("\n")

  def dump_visibility = (@visibility.map { |r| (r.map {|v| v ? 'Y' : '•'} ).join(" ") }).join("\n")

  def update_visibility
    @visibility = (0...@trees.length).map { |r| (0...@trees[0].length).map { |c| visible?(r,c) } }
  end

  def update_scenic
    @scenic = (0...@trees.length).map { |r| (0...@trees[0].length).map { |c| scenic_score_at(r,c) } }
  end

  def visible?(r,c)
    # p [r,c,'x',(0...@trees[0].length).map { |x| (x!=c) and (@trees[r][x] >= @trees[r][c]) }]
    # p [r,c,'y',((0...@trees.length).map {|y| (y!=r) and (@trees[y][c] >= @trees[r][c])})]
    (r == 0) or 
    (r == @trees.length - 1) or 
    (c == 0) or 
    (c == @trees[0].length - 1) or
    ((0...c).none? { |x| @trees[r][x] >= @trees[r][c] }) or 
    ((c+1...@trees[0].length).none? { |x| @trees[r][x] >= @trees[r][c] }) or 
    ((0...r).none? {|y| @trees[y][c] >= @trees[r][c]}) or
    ((r+1...@trees.length).none? {|y| @trees[y][c] >= @trees[r][c]})
  end

  def scenic_score_at(r,c)
    result = view_north(r,c).length * view_east(r,c).length * view_south(r,c).length * view_west(r,c).length
    # p [r,c,@trees[r][c], view_north(r,c),view_east(r,c),view_south(r,c),view_west(r,c), result] if r == 1 and c == 2
    # p [r,c,@trees[r][c], view_north(r,c).length,view_east(r,c).length,view_south(r,c).length,view_west(r,c).length, result]
    result
  end

  def view_north(r,c) = view(@trees[r][c], @trees[0...r].reverse.map {|row| row[c]})
  def view_east(r,c) = view(@trees[r][c], @trees[r][c+1..-1])
  def view_south(r,c) = view(@trees[r][c], @trees[r+1..-1].map {|row| row[c]})
  def view_west(r,c) = view(@trees[r][c], @trees[r][0...c].reverse)

  def view(height,list)
    result = list.take_while {|v| v < height}
    result << list[result.length] if result.length < list.length
    # p ["view", height, list, result]
    result
  end

  def visible_trees = @visibility.reduce(0) { |acc, row| acc + (row.reduce(0) { |acc2, col| acc2 + (col ? 1 : 0) }) }

  def max_scenic_score = @scenic.reduce(0) { |acc, row| [acc, row.reduce(0) { |acc2, col| [acc2, col].max } ].max }

end