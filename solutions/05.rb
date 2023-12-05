module Day05
  def self.prep_input(lines)
    seeds = lines.first.scan(/\d+/).map(&:to_i)
  
    transforms = lines[2..].each.with_object([]) do |line, transforms|
      next if line.empty?

      if line.include? ':'
        transforms << []  # add next table
        next
      end

      data = line.scan(/\d+/).map(&:to_i)

      transforms.last << data  # add entry
    end

    [seeds, transforms]
  end

  def self.min_location(lines)
    seeds, transforms = prep_input(lines)

    seeds.map do |seed_no|
      value = seed_no

      transforms.each do |table|
        table.each do |destination_start, source_start, length|
          if value >= source_start && (value - source_start) < length
            value = destination_start + (value - source_start)
            break   # stop proccessing this table
          end
        end

        # if no match is found in the table, `value` remains unchanged i.e. destination = source
      end


      value # output for the map
    end
      .min # lowest location
  end

  def self.min_location_ranges(lines)
    seeds, transforms = prep_input(lines)
    seed_ranges = seeds.each_slice(2).map { |start, length| [start, length, 0] }  # add start table id

    locations = []

    until seed_ranges.empty?
      range_start, range_length, from_table = seed_ranges.shift

      (from_table...transforms.length).each do |table_id|
        table = transforms[table_id]

        table.each do |destination_start, source_start, length|
          if range_start < source_start && (source_start - range_start) < range_length
            # intersects on the right
            # |-- input range --|
            #       |-- source range --|

            seed_ranges.unshift [range_start, source_start - range_start, table_id] # put remainder in queue

            range_length = range_length - (source_start - range_start)
            range_start = destination_start

            break
          end

          if range_start >= source_start && (range_start + range_length) <= (source_start + length)
            # fully overlaps
            #    |-- input range --|
            # |--- source range -----|

            range_start = destination_start + (range_start - source_start)
            # range_length remains the same

            break
          end

          if range_start >= source_start && (range_start - source_start) < length
            # intersects on the left
            #       |--- input range ---|
            # |--- source range -----|

            seed_ranges.unshift [source_start + length, (range_start + range_length) - (source_start + length), table_id]  # put remainder in queue

            range_length = length - (range_start - source_start)
            range_start = destination_start + (range_start - source_start)

            break
          end
        end

        # if no match is found in the table, range remains unchanged i.e. destination = source
      end

      locations << range_start
    end
    
    locations.min
  end
end
