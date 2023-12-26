module Day23
  UP = 0
  RIGHT = 1
  DOWN = 2
  LEFT = 3
  # (A + 2) % 4 gives ^A, the reverse direction 

  def self.hike(trails)
    y = 0
    x = trails[0].index('.')
    from = UP
    stack = []
    max_steps = 0
    steps = 0

    available_directions = proc do |x, y, from|
      out = []
      out << UP     unless UP == from     || y == 0                     || trails[y - 1][x] == '#' || trails[y - 1][x] == 'v'
      out << RIGHT  unless RIGHT == from  || x == trails[y].length - 1  || trails[y][x + 1] == '#' || trails[y][x + 1] == '<' 
      out << DOWN   unless DOWN == from   || y == trails.length - 1     || trails[y + 1][x] == '#' || trails[y + 1][x] == '^'
      out << LEFT   unless LEFT == from   || x == 0                     || trails[y][x - 1] == '#' || trails[y][x - 1] == '>'

      out
    end

    make_step = proc do |x, y, direction|
      dx = direction == LEFT ? -1 : direction == RIGHT ? 1 : 0
      dy = direction == UP ? -1 : direction == DOWN ? 1 : 0
      [x + dx, y + dy, (direction + 2) % 4]
    end

    loop do
      case trails[y][x]
      when '.'
        if y == trails.length - 1
          # came to the end
          max_steps = steps > max_steps ? steps : max_steps
          break if stack.empty?
          x, y, from, steps = stack.pop
          next
        end
        # choose direction
        directions = available_directions.call(x, y, from)
        # p directions
        if directions.empty?
          p(directions, x, y, steps) 
        end
        stack.concat directions.drop(1).map { |d| make_step.(x, y, d) + [steps + 1] } # if any
        # p stack
        x, y, from = make_step.call(x, y, directions.first)
        # p [x, y, from]
      else
        direction =  ['^', '>', 'v', '<'].index(trails[y][x])
        x, y, from = make_step.call(x, y, direction)
      end
      steps += 1
    end

    max_steps
  end

  def self.nonslippery_hike(trails)
    ##
    # 1. convert to graph
    y = 0
    x = trails[0].index('.')
    from = UP
    
    crossroads = [[x, y]]

    paths = []
    
    steps = 0

    stack = []

    available_directions = proc do |x, y, from|
      out = []
      out << UP     unless UP == from     || y == 0                     || trails[y - 1][x] == '#'
      out << RIGHT  unless RIGHT == from  || x == trails[y].length - 1  || trails[y][x + 1] == '#'
      out << DOWN   unless DOWN == from   || y == trails.length - 1     || trails[y + 1][x] == '#'
      out << LEFT   unless LEFT == from   || x == 0                     || trails[y][x - 1] == '#'

      out
    end

    make_step = proc do |x, y, direction|
      dx = direction == LEFT ? -1 : direction == RIGHT ? 1 : 0
      dy = direction == UP ? -1 : direction == DOWN ? 1 : 0
      [x + dx, y + dy, (direction + 2) % 4]
    end

    path = [x, y]

    loop do
      directions = available_directions.call(x, y, from)

      if y == trails.length - 1 || directions.length > 1
        # came to the end or to crossroad
        already_passed = crossroads.include? [x, y]
        path.concat [x, y, steps] # complete path
        paths << path # add to list
        crossroads << [x,y] unless already_passed # add crossroad to list
        if y == trails.length - 1 || already_passed
          # pop from stack
          break if stack.empty?
          x, y, to = stack.pop          
        else
          # add to stack and continue
          directions.drop(1).each do |d|
            stack << [x, y, d]
          end
          to = directions.first
        end
        path = [x, y]
        x, y, from = make_step.call(x, y, to)
        steps = 1
        next
      end

      x, y, from = make_step.call(x, y, directions.first)
      steps += 1
    end

    graph = Array.new(crossroads.length) { Array.new(crossroads.length, -1) }

    indices = crossroads.zip(0...crossroads.length).to_h

    crossroads.each { |x, y| graph[indices[[x, y]]][indices[[x, y]]] = 0 }

    paths.each do |xs, ys, xe, ye, steps|
      node_s = [xs, ys]
      node_e = [xe, ye]
      start_i = indices[node_s]
      end_i = indices[node_e]
      graph[start_i][end_i] = steps
      graph[end_i][start_i] = steps
    end

    ##
    # 2. search max steps

    start = indices[[trails[0].index('.'), 0]]
    finish = indices[[trails.last.index('.'), trails.length - 1]]

    steps_sum = 0
    max_steps = 0
    stack = []
    node = start
    history = []

    loop do
      history << node

      neighbors = graph[node].each_with_index.reject do |steps, i|
        steps < 1 || history.include?(i)
      end

      if node == finish || neighbors.empty?
        if node == finish
          max_steps = steps_sum > max_steps ? steps_sum : max_steps
        end
        break if stack.empty?
        node, steps_sum, history = stack.pop
        next
      end
      
      neighbors.drop(1).each do |steps, i|
        stack << [i, steps_sum + steps, history.dup]
      end

      steps, node = neighbors.first
      steps_sum += steps
    end

    max_steps
    
  end
end
