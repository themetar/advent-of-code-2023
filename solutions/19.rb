module Day19
  def self.workflows_and_parts(lines)
    blank_line_i = lines.find_index('')

    workflows = {}

    (0...blank_line_i).each do |i|
      line = lines[i]

      w_name, rules = line.match(/([a-z]+)\{(.+)\}/)[1, 2]

      workflows[w_name] = rules.split(',')
                                  .map do |rule|
                                    prop, op, value, next_w = rule.match(/(?:([xmas])([<>])(\d+):)?([a-zAR]+)/)[1, 4]

                                    {condition: prop && [prop, op, value.to_i] || nil, goto: next_w}
                                  end
    end

    parts = []

    ((blank_line_i + 1)...(lines.length)).each do |i|
      line = lines[i]

      parts << line.scan(/([xmas])=(\d+)/).each_with_object({}) { |(prop, value), part| part[prop] = value.to_i }
    end

    [workflows, parts]
  end

  def self.process_parts(lines)
    workflows, parts = workflows_and_parts(lines)

    accepted_parts = parts.filter do |part|
      w_name = 'in'

      until w_name == 'A' || w_name == 'R'      
        for rule in workflows[w_name] do
          prop, op, value = rule[:condition] || []
          if rule[:condition].nil? || part[prop].send(op, value) # no condition, or cond satisfied
            w_name = rule[:goto]        # set workflow
            break                       # exit these rules
          end
        end
      end

      w_name == 'A'
    end

    accepted_parts.map { |part| part.values.sum } .sum
  end

  def self.acceptable_combinations(lines)
    workflows, _ = workflows_and_parts(lines)

    range_part = {'x' => [1, 4000], 'm' => [1, 4000], 'a' => [1, 4000], 's' => [1, 4000]}
    w_name = 'in'
    queue = []

    accepted_ranges = []

    loop do
      workflows[w_name].each do |rule|
        prop, op, value = rule[:condition] | []
        from, to = range_part[prop]

        if rule[:condition].nil? ||  op == '<' && to < value || op == '>' && from > value
          # last rule, or wholly satisfied
          w_name = rule[:goto]
          break
        else
          # check condition
          if value.between?(*range_part[prop])
            # branch
            branch_part = range_part.each_with_object({}) { |(k, v), h| h[k] = v.dup }  # deep (first level) copy
            case op
            when '>'
              branch_part[prop][0] = value + 1
              range_part[prop][1] = value
            when '<'
              branch_part[prop][1] = value - 1
              range_part[prop][0] = value
            end
            unless rule[:goto] == 'A' || rule[:goto] == 'R'
              queue << [branch_part, rule[:goto]]
            else
              accepted_ranges << branch_part if rule[:goto] == 'A'
            end
          end
        end
      end

      accepted_ranges << range_part if w_name == 'A'

      if w_name == 'A' || w_name == 'R'
        break if queue.empty?
        range_part, w_name = queue.shift
      end
    end

    accepted_ranges.map { |r| r.reduce(1) { |acc, (_, (from, to))| acc * (to - from + 1) } } .sum
  end
end
