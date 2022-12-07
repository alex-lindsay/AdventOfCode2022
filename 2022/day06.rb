class Day06
  attr_reader :input

  def initialize(data)
    load(data) if data
  end

  def load(data)
    @input = data
  end

  def find_start_of_segment(n)
    (0...(@input.length-n)).each do |i|
      return i+n if @input[i...(i+n)].split("").uniq.length == n
    end
  end

  def find_start_of_packet = find_start_of_segment(4)
  def find_start_of_message = find_start_of_segment(14)
end