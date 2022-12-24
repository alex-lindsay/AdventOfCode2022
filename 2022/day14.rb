require 'json'
class Day14
  attr_reader :input, :bounds, :grid, :grains, :has_floor

  ENTRY_POINT = [500,0]
  CLEAR_CELL = "."
  STONE_CELL = "#"
  SAND_CELL = "o"

  def initialize(data, debug=false, has_floor=false)
    @debug = debug
    @has_floor = has_floor
    load(data) if data
  end

  def load(data)
    @input = data.split(/\n/).map(&:strip).map { |v| v.split(" -> ").map { |v2| v2.split(",").map(&:to_i) } }
    set_bounds
    @input << [[@bounds[:l]-2, @bounds[:b]+2], [@bounds[:r]+2, @bounds[:b]+2]] if @has_floor
    set_bounds if @has_floor
    p ["@input", @input] if @debug
    p ["@bounds", @bounds] if @debug
    set_grid
    add_sand
  end

  def set_bounds
    @bounds = { :t => @input[0][0][1], :l => @input[0][0][0], :b => @input[0][0][1], :r => @input[0][0][0] }
    @input.each do |line|
      line.each do |point|
        @bounds = { 
          :t => 0, 
          # :t => [@bounds[:t], point[1]].min, 
          :l => [@bounds[:l], point[0]].min, 
          :b => [@bounds[:b], point[1]].max, 
          :r => [@bounds[:r], point[0]].max, 
        }
      end
    end
  end

  def set_grid
    @grid = []
    (@bounds[:t]..@bounds[:b]).each { |_| @grid << Array.new(@bounds[:r] - @bounds[:l] + 1) { |i| CLEAR_CELL } }
    # add lines
    @input.each do |line|
      # p ["line", line]
      (0..line.length-2).each do |index|
        point = line[index]
        next_point = line[index+1]
        # p ["points", point, next_point]
        t = [point[1], next_point[1]].min - @bounds[:t]
        l = [point[0], next_point[0]].min - @bounds[:l]
        b = [point[1], next_point[1]].max - @bounds[:t]
        r = [point[0], next_point[0]].max - @bounds[:l]
        # p [t,l,b,r]
        (t..b).each { |y| (l..r).each { |x| @grid[y][x] = STONE_CELL } }
      end
    end
  end

  def add_sand
    grains = 0
    last_loc = nil
    while grains < 1000000 do
      final_loc = drop_grain(ENTRY_POINT)
      p ['add_sand', grains, final_loc] if @debug
      @grid[final_loc[1]][final_loc[0] - @bounds[:l]] = 'o' unless final_loc[0].nil?
      puts grid_as_string if @debug
      break if final_loc == last_loc
      last_loc = final_loc
      grains += 1 unless final_loc[0].nil?
    end
    p ['add_sand result', grains] if @debug
    @grains = grains
  end

  def loc_down(loc) = [loc[0], loc[1]+1]
  def loc_left(loc) = [loc[0]-1, loc[1]+1]
  def loc_right(loc) = [loc[0]+1, loc[1]+1]

  def grid_loc(loc) = [loc[1], loc[0] - @bounds[:l]]

  def grid_val(loc)
    @grid[loc[1]][loc[0] - @bounds[:l]] rescue NoMethodError begin
      p ["grid_val_RESCUE", loc, @bounds]
      raise NoMethodError
    end
  end

  def grid_val_down(loc) = grid_val(loc_down(loc))
  def grid_val_left(loc) = grid_val(loc_left(loc))
  def grid_val_right(loc) = grid_val(loc_right(loc))
  def is_out_of_bounds?(loc) = ((loc[0] < @bounds[:l]) or (loc[0] > @bounds[:r]) or (loc[1] > @bounds[:b]))
  def is_clear?(loc) = ((not is_out_of_bounds?(loc)) and (grid_val(loc) == CLEAR_CELL))
  def out_of_bounds(loc) = [nil, loc]

  def add_left
    @grid.each { |row| row.unshift(".") }
    @grid[-1][0] = "#"
    @bounds[:l] -= 1
  end
  
  def add_right
    @grid.each { |row| row << "." }
    @grid[-1][-1] = "#"
    @bounds[:r] += 1
  end

  def drop_grain(loc)
    i = 0
    curr_loc = loc
    while i < 10000000
      i += 1
      p ['drop_grain', i, curr_loc] if @debug
      # Rule 1
      p ["check down", loc_down(curr_loc), is_out_of_bounds?(loc_down(curr_loc)), is_clear?(loc_down(curr_loc))] if @debug
      return out_of_bounds(loc_down(curr_loc)) if is_out_of_bounds?(loc_down(curr_loc))
      if is_clear?(loc_down(curr_loc)) then
        puts "go down" if @debug
        curr_loc = loc_down(curr_loc)
        next
      end
      p ["check left", loc_left(curr_loc), is_out_of_bounds?(loc_left(curr_loc)), is_clear?(loc_left(curr_loc))] if @debug
      add_left if @has_floor and is_out_of_bounds?(loc_left(curr_loc))
      return out_of_bounds(loc_left(curr_loc)) if is_out_of_bounds?(loc_left(curr_loc))
      if is_clear?(loc_left(curr_loc)) then
        puts "go left" if @debug
        curr_loc = loc_left(curr_loc)
        next
      end
      p ["check right", loc_right(curr_loc), is_out_of_bounds?(loc_right(curr_loc)), is_clear?(loc_right(curr_loc))] if @debug
      add_right if @has_floor and is_out_of_bounds?(loc_right(curr_loc))
      return out_of_bounds(loc_right(curr_loc)) if is_out_of_bounds?(loc_right(curr_loc))
      if is_clear?(loc_right(curr_loc)) then
        puts "go right" if @debug
        curr_loc = loc_right(curr_loc)
        next
      end
      puts "landing" if @debug
      return curr_loc
    end 
  end

  def grid_as_string
    (@grid.map { |row| row.join }).join("\n")
  end
  
end