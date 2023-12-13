def number_segments(length, segments, prepend = 0, &block)
  segment, *rest = segments
  ones = 2 ** segment - 1

  rest_size = rest.sum + rest.length

  (rest_size..(length - segment)).each do |shift|
    # puts shift

    if rest_size == 0
      block.call prepend | (ones << shift)
    else
      number_segments(shift - 1, rest, prepend | (ones << shift), &block)
    end
  end
end

number_segments(6, [2, 2]) { |num| puts num.to_s(2).rjust(6, '0') }

puts 

number_segments(10, [1, 3, 2]) { |num| puts num.to_s(2).rjust(10, '0') }
