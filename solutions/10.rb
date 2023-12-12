module Day10

  class Sketch
    attr_reader :height, :width

    def initialize(lines)
      @pipes = lines.map { |line| line.chars }
      @height = @pipes.length
      @width =  @pipes.first.length
    end

    def start
      return @start_coords if @start_coords

      @start_coords = @pipes.each.with_index do |row, r|
        c = row.find_index('S')
        break [r, c] if c
      end

      # replace with regular pipe
      r, c = @start_coords
      connections = [[r, c-1], [r, c+1], [r-1, c], [r+1, c]].filter { |n_r, n_c| valid_coord?(n_r, n_c) }
                        .filter { |n_r, n_c| connected_cells(n_r, n_c).include?(@start_coords) }

      @pipes[r][c] = case connections
      when [[r, c-1], [r, c+1]] then '-'
      when [[r, c-1], [r-1, c]] then 'J'
      when [[r, c-1], [r+1, c]] then '7'
      when [[r, c+1], [r-1, c]] then 'L'
      when [[r, c+1], [r+1, c]] then 'F'
      when [[r-1, c], [r+1, c]] then '|'
      end

      @start_coords
    end

    def valid_coord?(r, c)
      r.between?(0, @height - 1) && c.between?(0, @width - 1)
    end

    def connected_cells(r, c)
      case @pipes[r][c]        
      when '|'
        [[r-1, c], [r+1, c]]
      when '-'
        [[r, c-1], [r, c+1]]
      when 'L'
        [[r-1, c], [r, c+1]]
      when 'J'
        [[r-1, c], [r, c-1]]
      when '7'
        [[r+1, c], [r, c-1]]
      when 'F'
        [[r+1, c], [r, c+1]]
      else
        []
      end
    end

    def at(r, c)
      @pipes[r][c]
    end
  end

  def self.max_distance(lines)
    chart = Sketch.new(lines)

    dist_chart = Array.new(chart.height) { Array.new(chart.width, nil) }

    # start coordinates
    r, c = chart.start

    distance = 0
    dist_chart[r][c] = distance

    ends = chart.connected_cells(r, c)

    loop do
      distance += 1

      a, b = ends

      return distance if a == b

      ends.each { |r, c| dist_chart[r][c] = distance }

      ends = ends.each.with_object([]) do |(r, c), obj|
        obj.concat chart.connected_cells(r, c).filter { |n_r, n_c| chart.valid_coord?(n_r, n_c) && dist_chart[n_r][n_c].nil? }
      end
    end
  end

  def self.inloop_tiles(lines)
    chart = Sketch.new(lines)

    mark_chart = Array.new(chart.height) { Array.new(chart.width, :T) }

    r, c = chart.start

    mark_chart[r][c] = :P

    ends = chart.connected_cells(r, c)

    loop do
      a, b = ends

      ends.each { |r, c| mark_chart[r][c] = :P }

      break if a == b

      ends = ends.each.with_object([]) do |(r, c), obj|
        obj.concat chart.connected_cells(r, c).filter { |n_r, n_c| chart.valid_coord?(n_r, n_c) && mark_chart[n_r][n_c] == :T }
      end
    end

    counter = 0

    complements = {
      '7' => 'L',
      'F' => 'J' 
    }

    for col in (0...chart.width)
      state = :outside
      last_pipe = nil
      prev_cell = :T

      for row in (0...chart.height)
        cell = mark_chart[row][col]
        if [prev_cell, cell] == [:P, :T] || [prev_cell, cell] == [:P, :P] && !chart.connected_cells(row, col).include?([row - 1, col])
          # pipe to ground
          # flip state
          if chart.at(row - 1, col) == '-' || complements[last_pipe] == chart.at(row - 1, col)
            state = state == :outside ? :inside : :outside
          end
        end

        if [prev_cell, cell] == [:T, :P] || [prev_cell, cell] == [:P, :P] && !chart.connected_cells(row, col).include?([row - 1, col])
          # from ground to pipe loop
          last_pipe = chart.at(row, col)
        end

        if cell == :T
          counter += 1 if state == :inside          
        end
        
        prev_cell = cell
      end
    end

    counter
  end
end
