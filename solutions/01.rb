module Day01
  DIGIT_WORDS = %w{zero one two three four five six seven eight nine}.freeze

  CONVERSION = DIGIT_WORDS.zip('0'..'9').to_h                       # 'zero' => '0', etc...
  CONVERSION.merge! DIGIT_WORDS.map(&:reverse).zip('0'..'9').to_h   # 'ozer' => '0', etc...
  CONVERSION.default_proc = proc { |_, k| k }                       # '0' => '0', etc...
  CONVERSION.freeze

  def self.calibration_sum_digits(lines)
    lines.reduce(0) { |acc, line| acc + line.scan(/\d/).values_at(0, -1).join.to_i }
  end

  def self.calibration_sum_all(lines)
    front_regexp = /\d|#{DIGIT_WORDS.join('|')}/
    back_regexp = /\d|#{DIGIT_WORDS.map(&:reverse).join('|')}/

    lines.reduce(0) do |acc, line|
      first = line[front_regexp]
      last = line.reverse[back_regexp]
      
      acc + (CONVERSION[first] + CONVERSION[last]).to_i
    end
  end
end
