class Day05
  attr_reader :stacks, :moves

  MOVE_PATTERN = /move (\d+) from (\d+) to (\d+)/

  def initialize(data)
    load(data) if data
  end

  def load(data)
    @stacks = []
    @moves = []
    load_boxes = true
    load_moves = false
    data.split("\n").map do |row|
      ((row.length + 1) / 4).times {@stacks << []} if @stacks.length == 0
      load_boxes, load_moves = load_box_row(row) if load_boxes
      load_move_row(row) if load_moves
    end
  end

  def load_box_row(row)
    return [false, true] if row.strip == ""
    return [true, false] if row.strip[0] == "1"
      ((row.length + 1) / 4).times do |i|
      box = row[i*4...(i+1)*4][0...3]
      # p [i, box]
      @stacks[i] << box[1] if box.strip != ""
    end
    return [true, false]
  end

  def load_move_row(row)
    matches = row.match(MOVE_PATTERN)
    # p matches
    @moves << [matches[1], matches[2], matches[3]].map(&:to_i) if row[0...4] == "move"
    # @moves << [row[5], row[-6], row[-1]].map(&:to_i) if row[0...4] == "move" <- stupid assumption about the number to move D'oh!
  end

  def perform_moves!
    @moves.each do |move| 
      perform_move!(move)
    end
  end

  def perform_move!(move)
    (move[0]).times do
      item = @stacks[move[1]-1].shift
      p ["ERROR", move] if item == nil
      @stacks[move[2]-1].unshift(item) if item != nil 
      # puts move.join(".") + ' ' +  self.to_str
    end
    # puts move.join(".") + ' ' +  self.to_str
    # puts move.join(".") + ' ' +  self.sizes
  end

  def perform_moves_9001!
    @moves.each do |move| 
      perform_move_9001!(move)
    end
  end

  def perform_move_9001!(move)
    items = @stacks[move[1]-1][0...move[0]]
    @stacks[move[1]-1] = @stacks[move[1]-1][move[0]..-1]
    @stacks[move[2]-1] = items + @stacks[move[2]-1]
    # p [move, @stacks]
    # puts move.join(".") + ' ' +  self.to_str
    # puts move.join(".") + ' ' +  self.sizes
  end

  def stack_tops
    (@stacks.map { |stack| stack[0] }).join()
  end

  def to_str
    (@stacks.map { |stack| stack.join("")}).join(" ")
  end

  def sizes
    (@stacks.map { |stack| stack.length }).join(" ") + ' - ' + (@stacks.reduce(0) { |acc, stack| acc + stack.length }).to_s
  end
end