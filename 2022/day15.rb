require 'json'
class Day15
  attr_reader :input, :sensors, :beacons, :debug, :range

  def initialize(data, debug=false, max_coord=4_000_000)
    @debug = debug
    @min_coord = 0
    @max_coord = max_coord
    load(data) if data
  end

  def load(data)
    @input = data.split(/\n/).map(&:strip).map { |v| ((/x=(.*), y=(.*):[^x]*x=(.*), y=(.*)/.match(v)).to_a)[1..-1].map(&:to_i) }
    @input = @input.map { |v| v << (v[2] - v[0]).abs + (v[3] - v[1]).abs}
    (0...@input.length).each { |i| p @input[i] } if @debug
    puts if @debug
    @input.sort_by! { |l, r| l[1] <=> r[1] }
    set_sensors
    set_beacons
    set_range
    (0...@input.length).each { |i| p [@input[i], @sensors[i], @beacons[i]] } if @debug
    puts if @debug
  end

  def set_sensors = @sensors = @input.map { |v| [v[0], v[1]] }

  def set_beacons = @beacons = @input.map { |v| [v[2], v[3]] }

  def set_range
    t = @input.reduce(0) { |acc, val| [acc, val[1] - val[4]].min }
    l = @input.reduce(0) { |acc, val| [acc, val[0] - val[4]].min }
    b = @input.reduce(0) { |acc, val| [acc, val[1] + val[4]].max }
    r = @input.reduce(0) { |acc, val| [acc, val[0] + val[4]].max }
    @range = {:t => t, :l => l, :b => b, :r => r}
  end

  def beacon_clear_spaces_in_row(row)
    result = 0
    (@range[:l]..@range[:r]).each do |col|
      puts col if col.modulo(10000) == 0
      # if the space is already a beacon move on
      next if @beacons.include?([col, row])
      # for each sensor, check the manhattan distance against the scannable distance - if less or equal count and move on.
      @sensors.each_with_index do |sensor, index|
        distance = (sensor[0] - col).abs + (sensor[1] - row).abs
        if distance <= @input[index][4] then
          result += 1
          break
        end
      end
    end
    result
  end

  def beacon_frequency
    # for each row (constrained by min and max)
    result = []
    ([@min_coord, @range[:t]].max..[@max_coord, @range[:b]].min).each do |row|
      # @debug = true if row == 2261192
      # @debug = false if row == 2261193
      row_ranges = [[[@min_coord, @range[:l]].max, [@max_coord, @range[:r]].min]]
      p [row, row_ranges] if @debug
      #   for each sensor
      @sensors.each_with_index do |sensor, sindex|
        distance = @input[sindex][4]
        # if the sensor is out of range continue
        v_distance = (row - sensor[1]).abs
        h_distance = (distance - v_distance).abs
        p [row, "sensor", sindex, @input[sindex], sensor, "v_distance", v_distance, "distance", distance, v_distance > distance] if @debug
        next if v_distance > distance
        # get the min and max ruled out by the sensor and subtract that range from all ranges in the available row
        # subtract the vertical distance from the sensor distance
        # that leaves the horizonal distance from the sensor to be removed as in range
        left = sensor[0] - h_distance
        right = sensor[0] + h_distance
        p [row, "range", "x", @input[sindex][0], "delta", h_distance, "-", [left, right]] if @debug
        row_ranges.to_enum.with_index.reverse_each do |range, i|
          p ["chop", "out of", [range[0], range[1]], "range", [left, right]] if @debug
          row_ranges.delete_at(i) if left <= range[0] and right >= range[1]
          row_ranges[i][0] = right+1 if left <= range[0] and right >= range[0] and right < range[1]
          row_ranges[i][1] = left-1 if left > range[0] and left <= range[1] and right >= range[1]
          if left > range[0] and right < range[1] then
            row_ranges << [row_ranges[i][0], left-1]
            row_ranges << [right+1, row_ranges[i][1]]
            row_ranges.delete_at(i)
          end
          p [row, row_ranges] if @debug
          puts if @debug
        end
      end
      #   if the row is length 0 skip to next row
      #   otherwise return the purportedly only possible location
      p [row_ranges.length, row, row_ranges[0], row_ranges[0][0] * 4_000_000 + row]  if row_ranges.length >= 1
      return row_ranges[0][0] * 4_000_000 + row if row_ranges.length == 1
      # result << [row, row_ranges, row_ranges[0][0] * 4_000_000 + row] if row_ranges.length == 1
    end
  end

end