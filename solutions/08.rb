module Day08

  class NodeLoop
    def self.from_lines(lines)
      instructions = lines.first.split('')

      network = lines.drop(2).each.with_object({}) do |line, h|
        f, l, r = line.scan(/[0-9A-Z]{3}/)
        h[f.to_sym] = [l.to_sym, r.to_sym]
      end

      NodeLoop.new(network, instructions)
    end

    def initialize(network, instructions)
      @network = network
      @instructions = instructions

      @znodes = Set.new(@network.keys.filter { |name| name.to_s[-1] == 'Z' })
    end

    def nodes
      @nodes ||= @network.keys
    end

    def steps_to_z(node = :AAA)
      step = 0

      @instructions.cycle do |direction|
        break if @znodes.include? node

        step += 1

        node = @network[node][direction == 'L' ? 0 : 1]
      end

      step
    end
  end
  
  def self.steps(lines)
    NodeLoop.from_lines(lines).steps_to_z
  end

  # I originally started searching for a general solution where an **A node has multiple **Z nodes in its path
  # so that every node fall on a **Z node at `k * loop + [n1, n2, ...]` steps. 
  #
  # But, actually every **A has a single **Z, which has the same out links as its **A, and the path repeats.
  # So the solution is to find the lowest common multiple of all the loop lengths
  def self.az_steps(lines)
    node_loop = NodeLoop.from_lines(lines)

    start_nodes = node_loop.nodes.filter { |name| name[-1] == 'A' }

    loops = start_nodes.map { |n| node_loop.steps_to_z(n) }

    loops.reduce { |a, b| a.lcm b}
  end
end
