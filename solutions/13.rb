module Day13
  def self.patterns_as_numbers(lines)
    lines.each.with_object([[]]) do |line, patterns|
      if line.empty?
        patterns << []
        next
      end

      patterns.last << line
    end
      .map do |pattern|
        horizontal = pattern.map { |row| row.tr('.#', '01').to_i(2) }
        vertical = pattern.first.length.times.map { |c| pattern.map { |row| row[c] } .join.tr('.#', '01').to_i(2) }

        [horizontal, vertical]
      end
  end

  def self.find_reflection(number_array)
    mirror_point = (number_array.length - 1).times.find do |p|
      len = [p, number_array.length - p - 1 - 1].min
      number_array[(p - len)..p] == number_array[(p + 1)..(p + 1 + len)].reverse
    end

    mirror_point && mirror_point + 1 || 0
  end

  def self.bit_count(integer)
    count = 0;
    while integer > 0
      count += integer & 1
      integer = integer >> 1
    end

    count
  end    

  def self.find_reflection_wtih_smudge(number_array)
    mirror_point = (number_array.length - 1).times.find do |p|
      len = [p, number_array.length - p - 1 - 1].min
      
      left = number_array[(p - len)..p]
      right = number_array[(p + 1)..(p + 1 + len)].reverse

      diff = left.zip(right).map { |lf, rg| lf ^ rg } .reduce(&:|)

      bit_count(diff) == 1
    end

    mirror_point && mirror_point + 1 || 0
  end

  def self.mirror_count(lines)
   patterns_as_numbers(lines).map do |horizontal, vertical|
      cols = find_reflection(vertical)
      rows = find_reflection(horizontal)

      cols + 100 * rows
    end
      .sum
  end

  def self.mirror_count_smudge(lines)
    patterns_as_numbers(lines).map do |horizontal, vertical|
      cols = find_reflection_wtih_smudge(vertical)
      rows = find_reflection_wtih_smudge(horizontal)

      cols + 100 * rows
    end
      .sum
  end
end
