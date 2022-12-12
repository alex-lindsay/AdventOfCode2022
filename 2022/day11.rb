class Day11
  attr_reader :monkeys, :master_modulus, :relief

  def initialize(data, relief=true, debug=false)
    @relief = relief
    @debug = debug
    load(data) if data
  end

  def load(data)
    @monkeys = {}
    # @data_blocks = data.split("\n\n").map { |row| row.strip.split(" ") }
    data.split(/\n\s*\n/).each do |data_block|
      monkey = Monkey.new(@monkeys, data_block, @relief, @debug)
      @monkeys[monkey.name] = monkey
    end
    @master_modulus = @monkeys.values.reduce(1) { |acc, monkey| acc * monkey.modulus }
    @monkeys.each { |key, monkey| monkey.modulus = master_modulus }
    # p ["master_modulus", @master_modulus]
  end

  def do_monkey_business = @monkeys.each { |k, v| v.examine_objects }

  def dump_items
    @monkeys.each { |k,v| puts "Monkey %s: %s" % [k, v.items.join(", ")] }
    puts ""
  end

  def dump_examinations
    @monkeys.each { |k,v| puts "Monkey %s: inspected %s item(s)" % [k, v.examinations] }
    puts ""
  end
end

class Monkey
  attr_reader :parent, :name, :items, :operation, :test, :if_true, :if_false, :examinations
  attr_accessor :modulus

  def initialize(parent, data, relief=true, debug=false)
    @parent = parent
    @relief = relief
    @debug = debug
    @name = rand(1..1000)
    @examinations = 0
    load(data) if data
  end

  def load(data)
    # matches = data.match /Monkey (\d+).*items: ([^\n]*)\n\s+Operation: ([^\n]*)\n\s+Test: ([^\n]*)\n\s.*true.*(\d+).*false.*(\d+)/
    matches = data.match /Monkey (\d+).*items: ([^\n]*)\n\s+.*new = ([^\n]*)\n\s+Test:\D*(\d+)\n\s.*true.*(\d+).*false.*(\d+)/m
    @name = matches[1]
    @items = matches[2].split(",").map { |v| v.strip.to_i }
    @operation = matches[3].split(" ")
    @test = matches[4].to_i
    @if_true = matches[5]
    @if_false = matches[6]
    # p matches
  end

  def dump
    p [@name, @items, @operation, @test, @if_true, @if_false]
  end

  def add_item(item)
    @items << item
  end

  def examine_objects
    puts "Monkey %s:" % @name if @debug
    @items.each_with_index do |item, index|
      puts "  Monkey examines and item with worry level %s" % item if @debug
      @examinations += 1
      # adjust for inspection
      new_item = do_operation(item, @operation) 
      puts "   Worry level from %s, %s to %s" % [item, @operation, new_item] if @debug
      # reduce for not broken
      new_item /= 3 if @relief
      puts "   Monkey gets bored with item. Worry level is divided by 3 to %s." % (new_item) if @relief and @debug
      # use new master modulus
      new_item = new_item.modulo @modulus
      # test for how to pass
      test_true = (new_item.modulo @test) == 0
      puts "   Current worry level is not divisible by %s." % @test if @debug
      # transfer
      new_monkey = test_true ? @if_true : @if_false
      puts "   Item with worry level %s is thrown to monkey %s." % [new_item, new_monkey] if @debug
      @parent[new_monkey].add_item(new_item)
    end
    @items = []
    puts "" if @debug
  end

  def do_operation(item, operation)
    val1 = operation[0] == "old" ? item : operation[0].to_i
    val2 = operation[2] == "old" ? item : operation[2].to_i
    (operation[1] == '+') ? (val1 + val2) : (val1 * val2)
  end

  def modulus = @test
end