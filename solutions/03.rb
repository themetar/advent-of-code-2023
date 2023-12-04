module Day03
  def self.tokenize_str(str, pattern)
    [].tap do |result|
      pos = 0

      while match_data = str.match(pattern, pos)
        result << [match_data[0], match_data.begin(0), match_data.end(0)]

        pos = match_data.end(0)
      end
    end
  end

  def self.part_numbers(lines)
    numbers = lines.map do |line|
      tokenize_str(line, /\d+/)
    end

    symbols = lines.map do |line|
      tokenize_str(line, /[^\d\.]/)
    end

    sum = 0

    numbers.each_with_index do |num_row, row|
      prev_row = (row - 1) >= 0 && symbols[row - 1] || []
      same_row = symbols[row]
      next_row = (row + 1) < lines.length && symbols[row + 1] || []

      relevant_symbols = prev_row + same_row + next_row

      num_row.each do |num_str, from_c, to_c|
        has_adjacent_sym = relevant_symbols.any? do |_, c, _|
          c.between?(from_c - 1, to_c)
        end

        sum += num_str.to_i if has_adjacent_sym
      end
    end

    sum
  end

  def self.gear_ratio(lines)
    numbers = lines.map do |line|
      tokenize_str(line, /\d+/)
    end

    gears = lines.map do |line|
      tokenize_str(line, /\*/)
    end

    sum = 0

    gears.each_with_index do |gearline, row|
      relevant_numbers = ((row - 1) >= 0 && numbers[row - 1] || []) +
                          numbers[row] +
                          ((row + 1) < lines.length && numbers[row + 1] || [])
                          
      gearline.each do |_, c, _|
        adjacent_numbers = relevant_numbers.filter { |_, from_c, to_c| c.between?(from_c - 1, to_c) }

        if adjacent_numbers.length == 2 # exactly two
          sum += adjacent_numbers.map { |val_str, _, _| val_str.to_i } .reduce(&:*)
        end
      end
    end

    sum
  end
end
