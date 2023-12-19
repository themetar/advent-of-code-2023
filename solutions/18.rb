module Day18
  class Pool
    attr_accessor :plot

    def initialize(instructions)
      @instructions = instructions
    end

    def draw_outline
      min_x, max_x = 0, 0
      min_y, max_y = 0, 0
      x, y = 0, 0

      @instructions.each do |dir, val|
        val = -val if dir == 'U' || dir == 'L'

        case dir
        when 'U', 'D' then
          y += val
          min_y = y < min_y ? y : min_y
          max_y = y > max_y ? y : max_y
        when 'L', 'R' then
          x += val
          min_x = x < min_x ? x : min_x
          max_x = x > max_x ? x : max_x
        end
      end

      @plot = Array.new(max_y - min_y + 1) { Array.new(max_x - min_x + 1, 0) }

      x, y = 0 - min_x, 0 - min_y

      @plot[y][x] = 1

      @instructions.each do |direction, value|
        case direction
        when 'U'
          ((y - value)..(y - 1)).each { |j| plot[j][x] = 1 }
          y -= value
        when 'D'
          ((y + 1)..(y + value)).each { |j| plot[j][x] = 1 }
          y += value
        when 'L'
          ((x - value)..(x - 1)).each { |j| plot[y][j] = 1 }
          x -= value
        when 'R'
          ((x + 1)..(x + value)).each { |j| plot[y][j] = 1 }
          x += value
        end
      end
    end

    def flood_outside
      width = @plot.first.length
      height = @plot.length
  
      neigbors = proc do |x, y|
        [         [x, y-1], 
        [x-1, y],           [x+1, y],
                  [x, y+1]          ]
      end
  
      at = proc { |x, y| x.between?(0, width - 1) && y.between?(0, height - 1) && @plot[y][x] || -1 }
  
      queue = []
  
      queue.concat ((-1)..width).to_a.product [-1]
      queue.concat ((-1)..width).to_a.product [height]
      queue.concat [-1].to_a.product (0...height).to_a
      queue.concat [width].to_a.product (0...height).to_a
  
      loop do
        break if queue.empty?
  
        x, y = queue.shift
  
        neigbors.(x, y).each do |nx, ny|
          if at.(nx, ny) == 0
            @plot[ny][nx] = -1 # mark as outside
            queue << [nx, ny]  # add to queue
          end
        end
      end
    end
  end
  
  def self.poolsize(lines)

    instructions = lines.map do |line|
      d, v = line.match(/([LRUD]) (\d+)/)[1,2]
      [d, v.to_i]
    end

    pool = Pool.new(instructions)
   
    pool.draw_outline

    pool.flood_outside

    pool.plot.map { |row| row.count { |cell| cell >= 0} }
          .sum
  end

  def self.large_poolsize(lines)
    # 1. transform hex instructions
    instructions = lines.map do |line|
      hex = line[/[0-9a-f]{6}/]

      size = hex[0, 5].to_i(16)
      direction = ['R', 'D', 'L', 'U'][hex[-1].to_i]

      [direction, size]
    end

    # 2. reduce coordinates scale
    # 2.1 find important coordinates
    x_coords = Set.new
    y_coords = Set.new

    x, y = 0, 0

    instructions.each do |direction, size|
      case direction
      when 'R' then x += size
      when 'L' then x -= size
      when 'D' then y += size
      when 'U' then y -= size
      end

      x_coords.add x
      y_coords.add y
    end

    # 2.2 map coordinates to grid: 0 is first coord, (1 is space between,) 2 is next coord 
    x_to_small = x_coords.sort.zip(0.step(by: 2)).to_h
    small_to_x = x_to_small.invert
    y_to_small = y_coords.sort.zip(0.step(by: 2)).to_h
    small_to_y = y_to_small.invert

    x, y = 0, 0
    s_x, s_y = x_to_small[0], y_to_small[0]

    # 2.3 convert instructions to reduced space
    small_instructions = instructions.map do |direction, size|
      case direction
      when 'R'
        x += size
        out_size = x_to_small[x] - s_x
        s_x = x_to_small[x]
      when 'L'
        x -= size
        out_size = s_x - x_to_small[x]
        s_x = x_to_small[x]
      when 'D' 
        y += size
        out_size = y_to_small[y] - s_y
        s_y = y_to_small[y]
      when 'U'
        y -= size
        out_size = s_y - y_to_small[y]
        s_y = y_to_small[y]
      end

      [direction, out_size]
    end

    # 3. build smaller pool
    pool = Pool.new(small_instructions)

    pool.draw_outline

    pool.flood_outside

    # 4. calculate big area using smaller pool
    area = 0

    pool.plot.each_with_index do |row, small_y|
      real_height = small_to_y[small_y] ? 1 : small_to_y[small_y + 1] - small_to_y[small_y - 1] - 1

      row.each_with_index do |cell, small_x|
        if cell >= 0 # inside
          real_width = small_to_x[small_x] ? 1 : small_to_x[small_x + 1] - small_to_x[small_x - 1] - 1

          area += real_height * real_width
        end
      end
    end

    area
  end
end
