module Day12
  
  def self.numbers_from_segments(length, segments, prepend = 0, &block)
    return enum_for(:numbers_from_segments,length, segments, prepend) unless block_given?

    segment, *rest = segments
    ones = 2 ** segment - 1
  
    rest_size = rest.sum + rest.length
  
    (rest_size..(length - segment)).each do |shift|
      # puts shift
  
      if rest_size == 0
        block.call prepend | (ones << shift)
      else
        numbers_from_segments(shift - 1, rest, prepend | (ones << shift), &block)
      end
    end
  end

  def self.possible_arrangements(pattern, segments)
    pattern = pattern.gsub(/\.+/, '.')
    d_mask = pattern.tr('.?#', '001').to_i(2) # damaged springs
    o_mask = pattern.tr('.?#', '100').to_i(2) # operational springs

    numbers_from_segments(pattern.length, segments).count { |num| num & d_mask == d_mask && num & o_mask == 0 }
    # numbers_from_segments(pattern.length, segments).count { |num| num & d_mask == d_mask }
  end

  # def self.

  def self.broken_springs(lines)
    lines.map do |line|
      pattern, segments = line.split(' ')

      segments = segments.split(',').map { |d| d.to_i }

      possible_arrangements(pattern, segments)
    end
      .sum    
  end
end
