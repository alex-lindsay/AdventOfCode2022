class Day10
  attr_reader :cycle, :register, :operations, :history

  def initialize(data)
    load(data) if data
  end

  def load(data)
    @cycle = 0
    @register = 1
    @history = [1]
    @operations = data.split("\n").map { |row| row.strip.split(" ") }
    do_operations
  end

  def do_operations = @operations.each do |operation| 
    # p operation
    self.send ("do_%s" % operation[0]).to_sym, operation
    # p [@cycle, @register]
  end

  def do_noop(operation)
    @cycle += 1
    @history << @register
  end
  
  def do_addx(operation)
    @history << @register
    val = operation[1].to_i
    @cycle += 2
    @register += val
    @history << @register
  end

  def signal_strength(i) = i * @history[i-1]

  def draw_output
    ((0..6).map { |y| ((0...40).map { |x| (x-1..x+1).include?(@history[(y*40)+x]) ? "#" : "."}.join) }).join "\n"
  end

end