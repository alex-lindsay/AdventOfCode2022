class Day09
  attr_reader :motions, :head, :tail, :tail_visited, :tail2, :tail2_visited

  MOTIONS = {
    :U => :go_up,
    :D => :go_down,
    :L => :go_left,
    :R => :go_right
  }

  def initialize(data)
    load(data) if data
  end

  def load(data)
    @motions = data.split("\n").map { |row| row.strip.split(" ") }
    @head = [0,0]
    @tail = [0,0]
    @tail_visited = [[0,0]]
    @tail2 = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],]
    @tail2_visited = [[0,0]]
    execute_motions
  end

  def execute_motions = @motions.each do |motion| 
    motion[1].to_i.times do
      self.send(MOTIONS[motion[0].to_sym])
      update_tail
      update_tail2
      # p [motion[0], "head", @head, "tail", @tail]
    end
    p [motion, @head, @tail2]
  end

  def go_up
    @head = [@head[0], @head[1]-1]
  end

  def go_down
    @head = [@head[0], @head[1]+1]
  end

  def go_left
    @head = [@head[0]-1, @head[1]]
  end

  def go_right
    @head = [@head[0]+1, @head[1]]
  end

  def update_tail
    new_tail = Marshal.load( Marshal.dump(@tail) )
    if @head[0] == @tail[0] then # head and tail in same column 
      # p 'column'
      new_tail[1] += 1 if @head[1] - @tail[1] == 2
      new_tail[1] -= 1 if @head[1] - @tail[1] == -2
    elsif @head[1] == @tail[1] then # head and tail in same row
      # p 'row'
      new_tail[0] += 1 if @head[0] - @tail[0] == 2
      new_tail[0] -= 1 if @head[0] - @tail[0] == -2
    elsif (@head[0] - @tail[0]).abs == 1 then # head and tail in adjacent columns
      # p 'diagonal'
      if (@head[1] - @tail[1]).abs == 2 then
        new_tail = [@head[0], (@head[1] + @tail[1]) / 2]
      end
    elsif (@head[1] - @tail[1]).abs == 1 then # head and tail in adjacent rows
      # p 'diaonal r'
      if (@head[0] - @tail[0]).abs == 2 then
        new_tail = [(@head[0] + @tail[0]) / 2, @head[1]]
      end
    end
    if new_tail != @tail
      @tail_visited << new_tail 
      @tail = new_tail
      # p ["tail_visited", @tail_visited]
    end
  end

  def update_tail2
    whole = [@head] + @tail2
    new_whole = Marshal.load( Marshal.dump(whole) )
    # p ["    whole", whole]
    for i in (0...new_whole.length-1) do
      # p ['>', i, new_whole[i], new_whole[i+1]]
      if new_whole[i+1][0] == new_whole[i][0] then # head and tail in same column 
        # p 'column'
        new_whole[i+1][1] += 1 if new_whole[i][1] - new_whole[i+1][1] == 2
        new_whole[i+1][1] -= 1 if new_whole[i][1] - new_whole[i+1][1] == -2
      elsif new_whole[i+1][1] == new_whole[i][1] then # head and tail in same row
        # p 'row'
        new_whole[i+1][0] += 1 if new_whole[i][0] - new_whole[i+1][0] == 2
        new_whole[i+1][0] -= 1 if new_whole[i][0] - new_whole[i+1][0] == -2
      elsif (new_whole[i][0] - new_whole[i+1][0]).abs == 1 then # head and tail in adjacent columns
        # p 'diagonal'
        if (new_whole[i][1] - new_whole[i+1][1]).abs == 2 then
          new_whole[i+1] = [new_whole[i][0], (new_whole[i][1] + new_whole[i+1][1]) / 2]
        end
      elsif (new_whole[i][1] - new_whole[i+1][1]).abs == 1 then # head and tail in adjacent rows
        # p 'diaonal r'
        if (new_whole[i][0] - new_whole[i+1][0]).abs == 2 then
          new_whole[i+1] = [(new_whole[i][0] + new_whole[i+1][0]) / 2, new_whole[i][1]]
        end
      elsif (new_whole[i][1] - new_whole[i+1][1]).abs == 2 then # long diagonal
        new_whole[i+1] = [(new_whole[i][0] + new_whole[i+1][0]) / 2, (new_whole[i][1] + new_whole[i+1][1]) / 2]
      end
      # p ['>', i, new_whole[i], new_whole[i+1]]
      # p ['?', i, new_whole[i+1], whole[i+1]]
      if new_whole[i+1] == whole[i+1]
        break
      end
      # p ['<', i, new_whole[i], new_whole[i+1]]
      # p ["new whole", new_whole]
    end
    @tail2 = new_whole[1..-1] if new_whole != whole 
    # p ["new_whole", new_whole]
    # p ["   @tail2", @tail2]
    @tail2_visited << @tail2[-1]
  end
end