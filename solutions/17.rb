module Day17
  def self.min_heat_loss(lines, min_steps = 1, max_steps = 3)
    heat_loss_map = lines.map { |line| line.each_char.map { |ch| ch.to_i } }
    
    height = heat_loss_map.length
    width = heat_loss_map.first.length

    is_valid = proc { |x, y| x.between?(0, width -1) && y.between?(0, height - 1) }

    h_acc_loss = Array.new(height) { Array.new(width, -1) }
    v_acc_loss = Array.new(height) { Array.new(width, -1) }

    x, y = 0, 0

    h_acc_loss[y][x] = v_acc_loss[y][x] = 0

    queue = [[0, 0, :horizontal], [0, 0, :vertical]]

    loop do
      break if queue.empty?

      x, y, orientation = queue.shift

      current_loss = orientation == :horizontal ? v_acc_loss[y][x] : h_acc_loss[y][x] # came from other orientation

      deltas = ((-max_steps..-min_steps).each + (min_steps..max_steps).each)

      case orientation
      when :horizontal
        destination = h_acc_loss
        deltas.filter { |dx| is_valid.call(x + dx, y) }
                            .each do |dx|
                              nx = x + dx
                              range = dx < 0 ? (nx...x) : ((x + 1)..nx)
                              heat_loss = current_loss + range.reduce(0) { |acc, ix| acc + heat_loss_map[y][ix] }
                              if destination[y][nx] < 0 || heat_loss < destination[y][nx]
                                destination[y][nx] = heat_loss  # set or update
                                queue << [nx, y, :vertical]
                              end
                            end
      when :vertical
        destination = v_acc_loss
        deltas.filter { |dy| is_valid.call(x, y + dy) }
                            .each do |dy|
                              ny  = y + dy
                              range = dy < 0 ? (ny...y) : ((y + 1)..ny)
                              heat_loss = current_loss + range.reduce(0) { |acc, iy| acc + heat_loss_map[iy][x] }
                              if destination[ny][x] < 0 || heat_loss < destination[ny][x]
                                destination[ny][x] = heat_loss
                                queue << [x, ny, :horizontal]
                              end
                            end
      end
    end

    h_acc_loss.last.last < v_acc_loss.last.last ? h_acc_loss.last.last : v_acc_loss.last.last
  end
end
