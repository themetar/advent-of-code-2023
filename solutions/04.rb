module Day04
  def self.winning_count(lines)
    lines.map do |line|
      _, winning_nums, having_nums = line.split(/[:|]/)

      winning_nums = winning_nums.split(' ')
      having_nums = having_nums.split(' ')

      winning_nums.count { |num| having_nums.include? num }
    end
  end

  def self.scratchcards_points(lines)
    winning_count(lines).map { |count| count > 0 ? 2 ** (count - 1) : 0 } .sum 
  end

  def self.scratchcards_count(lines)
    wins = winning_count(lines)

    copies = Array.new(lines.length, 1)

    wins.each_with_index do |count, card_no|
      count.times { |i| copies[card_no + 1 + i] += copies[card_no] }
    end

    copies.sum
  end
end
