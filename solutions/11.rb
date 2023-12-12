module Day11
  def self.galaxy_distances_total(lines, multiplier = 2)
    empty_rows = Set.new(0...lines.length)
    empty_columns = Set.new(0...lines[0].length)
    filled_rows = Hash.new(0)
    filled_columns = Hash.new(0)
    
    lines.each.with_index do |line, row|
      line.each_char.with_index do |char, col|
        if char == '#'
          filled_rows[row] += 1
          filled_columns[col] += 1
          empty_rows.delete row
          empty_columns.delete col
        end
      end
    end

    total = 0

    cols_sorted = filled_columns.to_a.sort { |(k1, _), (k2, _)| k1 - k2 }

    rows_sorted = filled_rows.to_a.sort { |(k1, _), (k2, _)| k1 - k2 }

    [[cols_sorted, empty_columns], [rows_sorted, empty_rows]].each do |filled, empty|
      filled.combination(2) do |(k, x), (m, y)|
        delta = m - k

        multiplied = empty.count { |e| e.between?(k, m) }

        distance = delta + multiplied * (multiplier - 1)

        total += distance * x * y
      end
    end

    total
  end
end
