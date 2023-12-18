module Day16
  LEFT = 1
  RIGHT = 2
  UP = 4
  DOWN = 8

  def self.energized_count(lines, start = [-1, 0], direction = RIGHT)
    width = lines.first.length
    height = lines.length

    energized_grid = Array.new(height) { Array.new(width, 0) }

    valid_cell = proc { |x, y| x.between?(0, width - 1) && y.between?(0, height - 1) }

    reverse_dir = proc do |dir|
      case dir
      when RIGHT then LEFT
      when LEFT then RIGHT
      when UP then DOWN
      when DOWN then UP
      end
    end

    x, y = start

    queue = []

    loop do
      new_x = direction == RIGHT ? x + 1 : direction == LEFT ? x - 1 : x  
      new_y = direction == DOWN ? y + 1 : direction == UP ? y - 1 : y

      unless valid_cell.(new_x, new_y) && energized_grid[new_y][new_x] & direction == 0
        break if queue.empty?

        x, y, direction = queue.shift

        next
      end

      energized_grid[new_y][new_x] |= direction

      case lines[new_y][new_x]
      when '-'
        if direction == UP || direction == DOWN
          queue << [new_x, new_y, RIGHT]
          direction = LEFT
        end
      when '|'
        if direction == LEFT || direction == RIGHT
          queue << [new_x, new_y, DOWN]
          direction = UP
        end
      when '\\'
        direction = case direction
        when RIGHT then DOWN
        when LEFT then UP
        when DOWN then RIGHT
        when UP then LEFT 
        end
      when '/'
        direction = case direction
        when RIGHT then UP
        when LEFT then DOWN
        when DOWN then LEFT
        when UP then RIGHT 
        end
      end

      x = new_x
      y = new_y
    end

    energized_grid.reduce(0) do |acc, row|
      acc + row.count { |c| c > 0 }
    end
  end

  def self.find_best(lines)
    h = lines.length
    w = lines.first.length

    [(0...w).to_a.product([-1]).map { |x, y| energized_count(lines, [x, y], DOWN) } .max,
     (0...w).to_a.product([-1]).map { |x, y| energized_count(lines, [x, y], UP) } .max,
     [-1].product((0...h).to_a).map { |x, y| energized_count(lines, [x, y], RIGHT) } .max,
     [w].product((0...h).to_a).map { |x, y| energized_count(lines, [x, y], LEFT) } .max].max
    
  end
end
