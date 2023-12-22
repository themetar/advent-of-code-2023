module Day22
  def self.parse_input(lines)
    lines.map do |line|
      line.scan(/\d+/).map(&:to_i)
    end
  end

  def self.get_support_network(lines)
    bricks = parse_input(lines)

    x_minmax = bricks.map{_1[0]}.minmax
    y_minmax = bricks.map{_1[1]}.minmax

    # stats
    # puts "brick edge z-sorted? #{bricks.all? { |b| b[2] <= b[5]}}"
    # puts "brick edge x-sorted? #{bricks.all? { |b| b[0] <= b[3]}}"
    # puts "brick edge y-sorted? #{bricks.all? { |b| b[1] <= b[4]}}"
    # puts "list z-sorted? #{bricks.each_cons(2).all? { |a, b| a[5] <= b[5] } }"
    # puts "x-y area: #{x_minmax} #{y_minmax} "

    bricks.sort! { |a, b| a[2] - b[2] } # sort by first z-coord

    height_map = Array.new(y_minmax[1] + 1) { Array.new(x_minmax[1] + 1, 0) }

    settled = bricks.map do |x1, y1, z1, x2, y2, z2|
      brick_height = z2 - z1 + 1
      floor_heigths = (x1..x2).reduce([]) { |acc, x| acc + height_map[y1..y2].map{ |row| row[x] } }
      floor = floor_heigths.max
      # update heightmap
      (x1..x2).each { |x| (y1..y2).each{ |y| height_map[y][x] = floor + brick_height } }
      [x1, y1, floor + 1, x2, y2, floor + brick_height]
    end

    settled.sort! { |a, b| a[2] - b[2] }  # coords were updated, now reorder bricks

    supports = Array.new(bricks.length) { [] }
    supported_by = Array.new(bricks.length) { [] }

    settled.each_with_index do |(x1, y1, z1, x2, y2, z2), i|
      above = ((i+1)...).take_while { |j| settled[j] && settled[j][2] <= z2 + 1 }
                          .reject { |j| settled[j][2] == z2 }
      
      above = above.map { |j| settled[j] } .zip above
          
      above.each do |(ox1, oy1, oz1, ox2, oy2, oz2), oi|
        are_touching = (x1..x2).any? do |x|
          (y1..y2).any? do |y|
            x.between?(ox1, ox2) && y.between?(oy1, oy2)
          end
        end

        if are_touching
          supports[i] << oi
          supported_by[oi] << i
        end
      end
    end

    [supports, supported_by, settled]
  end

  def self.jenga(lines)
    supports, supported_by = get_support_network(lines)

    colleagues = supported_by.each.with_object(Set.new) do |entries, set|
      set.merge entries if entries.length > 1
    end
    
    supported_by.each { |entries| colleagues.subtract entries if entries.length == 1 }

    leafs = supports.count { |entries| entries.empty? }

    colleagues.length + leafs
  end

  def self.destruction(lines)
    supports, supported_by, settled = get_support_network(lines)
    
    counts = settled.each_with_index.map do |_, i|
      base = [i]
      above = supports[i]
      count = 0
      until above.empty?
        disintegrated = above.filter { |j| (supported_by[j] - base).empty? }
        count += disintegrated.length
        base.concat(disintegrated)
        above = disintegrated.map { |i| supports[i] } .flatten.uniq
      end
      
      count
    end
    
    counts.sum
  end
end
