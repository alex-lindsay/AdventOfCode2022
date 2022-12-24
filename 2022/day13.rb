require 'json'
class Day13
  attr_reader :input

  def initialize(data, debug=false)
    @debug = debug
    load(data) if data
  end

  def load(data)
    data.gsub!("[]",'["nil"]')
    @input = data.split(/\n\W*\n/).map(&:strip).map { |v| v.split(/\n/).map(&:strip).map { |t| JSON.parse(t) } }
    @input = replace_nils @input
    p ["@input", @input] if @debug
  end

  def replace_nils(arr)
    arr.delete_if { |v| v == "nil" }
    arr.map { |v| v.is_a?(Array) ? replace_nils(v) : v }
  end

  def comparisons
    @input.map { |v| compare(v[0], v[1])}
  end

  def compare(left, right, depth=0)
    puts "" if depth == 0 and @debug
    puts "%s- Compare %s vs %s" % [("  " * depth), left, right] if @debug
    return nil if left.nil? and right.nil?
    return true if left.nil?
    return false if right.nil?
    depth += 1
    # Rule 1
    if left.is_a? Integer and right.is_a? Integer then
      puts "%s- Compare %s vs %s" % [("  " * depth), left, right] if @debug
      return true if left < right
      return false if left > right
      return nil
    end
    # Rule 3
    if left.is_a? Integer then
      puts "%s- Mixed types; convert left to [%s] and retry comparison" % [("  " * depth), left] if @debug
      left = [left]
    end
    if right.is_a? Integer then
      puts "%s- Mixed types; convert right to [%s] and retry comparison" % [("  " * depth), right] if @debug
      right = [right]
    end
    # Strip fake 'nils' for empty elements
    left = left.filter { |v| v != 'nil' }
    right = right.filter { |v| v != 'nil' }

    result = compare(left[0], right[0], depth)

    result.nil? ? compare(left[1..-1], right[1..-1], depth) : result
  end

  def sort(seed=[])
    result = seed.clone
    # add the items to the result
    @input.each { |pair| pair.each { |item| result << item }}
    # do an in place sort using the compare function...
    result = quicksort result
    result
  end

  def quicksort(arr, low=0, hi=arr.length-1)
    return arr if low >= hi || low < 0
      
    p = partition(arr, low, hi) 
        
    quicksort(arr, low, p - 1) # Left
    quicksort(arr, p + 1, hi) # Right
    arr
  end

  def partition(arr, low, hi)
    pivot = arr[hi]

    i = low - 1
  
    (low..hi-1).each do |j|
      # If the current element is less than or equal to the pivot
      if compare(arr[j], pivot) then 
        # Move the pivot up
        i += 1
        # Swap the current element with the element at the temporary pivot index
        temp = arr[i]
        arr[i] = arr[j]
        arr[j] = temp
      end
    end
  
    # Adjust the pivot
    i += 1
    temp = arr[i]
    arr[i] = arr[hi]
    arr[hi] = temp

    return i 
  end

  def compare1(left, right, depth=0)
    # Rule 1
    puts "" if depth == 0 and @debug
    if left.is_a?(Integer) and right.is_a?(Integer) then
      puts "%s- Compare %s vs %s" % [("  " * depth), left, right] if @debug
      return true if (left < right) 
      return false if (left > right)
    end
    # Rule 2
    if left.is_a?(Array) and right.is_a?(Array) then
      left = left.filter { |v| v != 'nil' }
      right = right.filter { |v| v != 'nil' }
      puts "%s- Compare %s vs %s" % [("  " * depth), left, right] if @debug
      return true if left.length == 0
      return false if right.length == 0
      return (left[0] == right[0]) ? compare(left[1..-1], right[1..-1], depth+1) : compare(left[0], right[0], depth+1)
    end
    # Rule 3
    puts "%s- Compare %s vs %s" % [("  " * depth), left, right] if @debug
    return compare([left], right, depth+1) if left.is_a?(Integer) and right.is_a?(Array)
    return compare(left, [right], depth+1) if left.is_a?(Array) and right.is_a?(Integer)

    return true if left.nil?
    return false if right.nil?
  end
end