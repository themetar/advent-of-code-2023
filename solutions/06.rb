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
    1.upto(time / 2).count { |push_time| (time - push_time) * push_time > distance } * 2 - (time.even? && (time / 2) ** 2 > distance ? 1 : 0)
  end
end
