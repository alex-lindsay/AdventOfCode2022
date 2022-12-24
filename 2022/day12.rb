class Day12 # take 3
  attr_reader :input, :root_loc, :target_loc, :partial_paths, :visited_locs

  def initialize(data, debug=false)
    @debug = debug
    load(data) if data
  end

  def load(data)
    @input = data.split("\n").map(&:strip)
    p ["@input", @input] if @debug
    @root_loc = locate "S"
    @target_loc = locate "E"
    p ["@root_loc", @root_loc, "@target_loc", @target_loc] if @debug
    @partial_paths = [[@root_loc]] # start with the root location as the first known partial path
    p ["@partial_paths", @partial_paths] if @debug
    @visited = []
    @shortest_path = nil
  end

  def locate(ch) = (@input.each_with_index.map { |row, y| [row.index(ch), y] }).find { |v| !v[0].nil? }

  def cell(c) = ((0...input.length).include?(c[1]) and (0...input[0].length).include?(c[0])) ? @input[c[1]][c[0]] : nil

  def height(c) = cell(c).nil? ? nil : (cell(c).sub("S","a").sub("E","z")).ord

  def shortest_path
    return @shortest_path if !@shortest_path.nil?
    old_path_length = 0
    # avoid recursion by using a call stack
    # use a list of visited cells so that if we land on a cell we've visited before, we don't redo work.
    # as long as there are more paths to explore, explore them
    while @partial_paths.length != 0
      # use a FIFO queue of paths
      next_path = @partial_paths.shift
      path_length = next_path.length
      if path_length != old_path_length
        print path_length.to_s + "." if @debug
        old_path_length = path_length
      end
      next_loc = next_path[-1]
      next if @visited.include? next_loc
      @visited << next_loc
      p ["visited", @visited] if @debug
      # p ["partial_paths", @partial_paths.length, "next_path", next_path.length, next_path[-5..-1]]
      neighbors = neighbors_of(next_loc, next_path)
      p [@target_loc, "partial_paths", @partial_paths.length, "next_path", next_path.length, next_path, "neighbors", neighbors] if @debug
      @shortest_path = next_path + [@target_loc] if neighbors.include? @target_loc
      return @shortest_path if neighbors.include? @target_loc
      neighbors.each { |n| @partial_paths << next_path + [n] }
    end
  end

  def neighbors_of(l, p) = [[l[0]-1, l[1]], [l[0]+1, l[1]], [l[0], l[1]-1], [l[0], l[1]+1]].filter { |v| in_board(v) and !p.include?(v) and reachable(l,v) and !@visited.include?(v) }
  
  def in_board(l) = !cell(l).nil?

  def reachable(from, to) = height(to) <= (height(from) + 1)

end