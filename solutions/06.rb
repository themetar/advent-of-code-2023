module Day06
  def self.race_margin(lines)
    times = lines[0].scan(/\d+/).map(&:to_i)
    distances = lines[1].scan(/\d+/).map(&:to_i)
  
    times.zip(distances)
          .map { |time, distance| ways_to_beat(time, distance) }
          .reduce(&:*)
  end

  def self.single_race(lines)
    time = lines[0].scan(/\d+/).join.to_i
    distance = lines[1].scan(/\d+/).join.to_i

    ways_to_beat(time, distance)
  end

  def self.ways_to_beat(time, distance)
    # uses quadratic equation

    # x + y = time; x * y > distance =>
    # => y = time - x; x * (time - x) > distance
    # => -x^2 + time*x - distance > 0
    
    # a = -1, b = time, c = - distance
    #
    # zero solutions are (-b +- sqrt(b^2 - 4ac))/2a
    # i.e. -b/2a +- sqrt(b^2 - 4ac)/2a

    mid = time / 2.0

    under_sqrt = time ** 2 - 4 * distance
    
    return 0 if under_sqrt < 0

    part = Math.sqrt(under_sqrt) / -2

    left = mid + part
    right = mid - part

    # we're looking for integer solutions that give bigger than 0 result
    left = left == left.ceil && left + 1 || left.ceil
    right = right == right.floor && right - 1 || right.floor

    # return number of integers between left and right
    right - left + 1
  end
end
