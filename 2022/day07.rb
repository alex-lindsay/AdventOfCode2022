class Day07
  attr_reader :root_dir, :current_dir, :output, :current_line

  def initialize(data)
    load(data) if data
  end

  def load(data)
    @root_dir = Entry.new("/", nil, 0, {})
    @current_dir = @root_dir
    @output = data.split("\n").map(&:strip)
    @current_line = 0
    while @current_line < @output.length do
      parse_current_line
    end
  end

  def parse_current_line
    current_row = @output[@current_line]
    # p [@current_line, current_row]
    matches = current_row.match /\$ (\S+)(?: (\S+))?/
    run_cd(matches[2]) if matches[1] == "cd"
    run_ls if matches[1] == "ls"
  end
  
  def run_cd(dir)
    puts "move to %s:" % dir
    if dir == "/" then
      @current_dir = @root_dir 
    elsif dir == ".."
      @current_dir = @current_dir.parent
      puts " now in %s" % @current_dir.name
    elsif @current_dir.contents != nil
      @current_dir = @current_dir.contents[dir] unless [",",".."].include?(dir)
    end
    @current_line += 1
  end

  def run_ls
    puts "Parse command output from ls %s:" % @current_dir.name
    @current_line += 1
    current_row = @output[@current_line]
    # p current_row
    while @current_line < @output.length and not current_row.start_with?("$") do
      puts "Add %s to %s" % [current_row, @current_dir.name]
      matches = current_row.match /(\S+) (\S+)/
      # p matches
      # puts @current_dir.name + " - " + @current_dir.contents.length.to_s
      @current_dir.add_dir(matches[2]) if matches[1] == 'dir'
      @current_dir.add_file(matches[2], matches[1]) unless matches[1] == 'dir'
      @current_line += 1
      current_row = @output[@current_line]
    end
  end
end

class Entry
  attr_reader :name, :parent, :size, :contents

  def initialize(name, parent, size, contents)
    @name = name
    @parent = parent
    @size = size.to_i
    @contents = contents
  end

  def add_dir(name)
    # p [name, @contents]
    @contents[name] = Entry.new(name, self, 0, {})
  end

  def add_file(name, size)
    @contents[name] = Entry.new(name, self, size, nil)
  end

  def dump(depth=0)
    puts "%s %s (%s)" % [' ' * depth, @name, @size]
    @contents.each { |key, item| item.dump(depth+1) } if is_dir? 
  end

  def update_size
    if is_dir? then
      # puts @name
      @contents.each do |key, item|
        item.update_size
      end
      @size = @contents.reduce(0) {|acc, (key, item)| acc + item.size}
    end
  end

  def flattened
    result = [self]
    @contents.each { |key, item| result += item.flattened } if is_dir?
    result
  end

  def is_dir? = !@contents.nil?

end