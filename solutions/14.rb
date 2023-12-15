module Day14
  # lines to matrix of symbols
  def self.prep_input(lines)
    lines.map do |line|
      line.each_char.map do |char|
        case char
        when '.' then :empty
        when 'O' then :round
        when '#' then :cube
        end
      end
    end
  end

  # part one of puzzle
  def self.north_load(lines)
    platform = prep_input(lines)

    platform_length = platform.length
    platform_width = platform.first.length

    platform_width.times.reduce(0) do |acc, col|
      max_load = platform_length + 1 # 1 plus
      acc + platform_length.times.reduce(0) do |acc, row|
        acc + case platform[row][col]
        when :round
          max_load -= 1
        when :cube
          max_load = platform_length - row
          0
        else
          0
        end
      end
    end
  end

  # transform matrix into vertical or horizontal segments
  def self.build_segments(platform, width, length, direction = :NS)
    first_axis = direction == :NS ? width : length
    second_axis = direction == :NS ? length : width

    max_to = second_axis - 1

    Array.new(first_axis) do |a|
      second_axis.times.each_with_object([{from: 0, to: max_to, count: 0}]) do |b, segments|
        cell = direction == :NS ? platform[b][a] : platform[a][b]
        case cell
        when :round, :empty
          segments << {from: b, to: max_to, count: 0} unless segments.last[:to] >= b
          segments.last[:count] += 1 if cell == :round
        when :cube
          if segments.last[:from] == b
            segments.last[:from] = b + 1
            next
          end
          segments.last[:to] = b - 1 unless segments.last[:to] < b 
        end
      end
    end
  end

  # sets all segment[:count] to 0
  def self.clear_segments(segments)
    segments.each do |seg_line|
      seg_line.each { |segment| segment[:count] = 0 }
    end    
  end

  # set counts to horiz/vert segments from vert/horiz segments 
  def self.fill_segments(origin, destination, direction = :low)
    clear_segments(destination)
    
    origin.each_with_index do |seg_line, i|
      seg_line.each do |segment|
        segment => {from:, to:, count:}
        range = direction == :low ? (from..(from + count - 1)) : ((to - count + 1)..to)
        range.each do |j|
          destination[j].find { |seg| i.between?(seg[:from], seg[:to]) }[:count] += 1
        end
      end
    end
  end

  # sum of count in each row of segments
  def self.count_signature(segments)
    segments.map do |seg_line|
      seg_line.reduce(0) { |acc, seg| acc + seg[:count] }
    end    
  end

  # part two of the puzzle
  def self.cycle_load(lines)
    platform = prep_input(lines)

    north_south_segments = build_segments(platform, platform.first.length, platform.length)
    
    east_west_segments = build_segments(platform, platform.first.length, platform.length, :EW)
    clear_segments(east_west_segments)

    pattern = [:north, :east, :south, :west]

    sig_history = []

    loop_start = nil
    first_repeat = nil

    # it won't reach to a billion
    1_000_000_000.times do |counter|

      signatures = pattern.map do |direction|
        case direction
        when :north
          fill_segments(north_south_segments, east_west_segments, :low)
          count_signature(east_west_segments) # north sig
        when :south
          fill_segments(north_south_segments, east_west_segments, :high)
          count_signature(east_west_segments) # south sig
        when :east
          fill_segments(east_west_segments, north_south_segments, :low)
          count_signature(north_south_segments) # east sig
        when :west
          fill_segments(east_west_segments, north_south_segments, :high)
          count_signature(north_south_segments) # west sig
        end
      end

      prev_cycle = sig_history.find_index { |prev_signatures| prev_signatures.zip(signatures).all? { |ps, s| ps == s } }

      if prev_cycle
        loop_start = prev_cycle
        first_repeat = counter
        break
      end

      sig_history << signatures
    end
    
    target = 999_999_999

    target = sig_history[target] || loop_start + (target - loop_start) % (first_repeat - loop_start)

    # 2 is south; west tilt won't affect the north load after the cycle
    sig_history[target][2].each_with_index.reduce(0) do |acc, (count, row)| 
      acc + (platform.length - row) * count
    end
  end
end
