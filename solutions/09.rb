module Day09
  def self.next_val(seq, acc = 0)
    return 0 if seq.all?(0)

    seq.last + next_val(seq.each_cons(2).map { |a, b| b - a })
  end

  def self.prev_val(seq)
    return 0 if seq.all?(0)

    seq.first - prev_val(seq.each_cons(2).map { |a, b| b - a })
  end

  def self.extrapolated_vals(lines)
    lines.map { |line| line.split(' ').map(&:to_i) }
      .map { |sequence| next_val(sequence) }
      .sum
  end

  def self.extrapolated_vals_rev(lines)
    lines.map { |line| line.split(' ').map(&:to_i) }
      .map { |sequence| prev_val(sequence) }
      .sum
  end
end
