module Day12

  # def self.ways_to_fit(pattern, segments)
  #   length = pattern.length

  #   segment, *rest = segments

  #   if segment.nil?
  #     return 0 if pattern['#']
  #     return 1
  #   end

  #   octo = '#' * segment
  
  #   rest_size = rest.sum + rest.length

  #   span_size = length - rest_size + (rest_size != 0 ? 1 : 0)


  #   range = rest_size.zero? ? (0..(span_size - segment)) : (0..(span_size - segment - 1))
  
  #   range.reduce(0) do |acc, pad|
  #     str = '.' * pad + octo + (rest_size.zero? ? '' : '.')

  #     sub_pattern = pattern[0, str.length]

  #     # puts str
  #     # puts sub_pattern
  #     # puts
      

  #     if sub_pattern.chars.zip(str.chars).all? { |p, s| p == '?' || p == s }
  #       if str.length == length
  #         acc + 1
  #       else
  #         acc + ways_to_fit(pattern[str.length, length], rest)
  #       end
  #     else
  #       acc
  #     end
  #   end
  # end

  def self.ways_to_fit(pattern, segments)
    segment, *rest = segments

    if segment.nil?
      return 0 if pattern['#']
      return 1
    end

    regex = rest.empty? ? /[^#]*(\#{#{segment}})/ : /[^#]*(\#{#{segment}})[^#]/

    pos = 0

    counter = 0

    while match =  regex.match(pattern, pos)
      
    end
    


  # def self.possible_arrangements(pattern, segments)
  #   pattern = pattern.gsub(/\.+/, '.')
  #   d_mask = pattern.tr('.?#', '001').to_i(2) # damaged springs
  #   o_mask = pattern.tr('.?#', '100').to_i(2) # operational springs

    # numbers_from_segments(pattern.length, segments).count { |num| num & d_mask == d_mask && num & o_mask == 0 }
    # numbers_from_segments(pattern.length, segments).count { |num| num & d_mask == d_mask }
  # end

  # def self.

  def self.broken_springs(lines)
    lines.map do |line|
      pattern, segments = line.split(' ')

      segments = segments.split(',').map { |d| d.to_i }

      ways_to_fit(pattern, segments)
    end
      .sum    
  end

  def self.quintuple(lines)
    lines.map do |line|
      pattern, segments = line.split(' ')

      pattern = ([pattern] * 5).join('?')
      segments = ([segments] * 5).join(',')

      segments = segments.split(',').map { |d| d.to_i }

      ways_to_fit(pattern, segments)
    end
    .sum
  end


end
