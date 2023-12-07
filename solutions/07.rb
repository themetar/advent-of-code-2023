module Day07
  LABEL_VALUES = %w{2 3 4 5 6 7 8 9 T J Q K A }.zip(0..12).to_h.freeze
  TYPE_VALUES = %i{highest one_pair two_pair three_kind full_house four_kind five_kind }.zip(0..6).to_h.freeze

  LABEL_VALUES_JOKER = %w{J 2 3 4 5 6 7 8 9 T Q K A }.zip(0..12).to_h.freeze

  def self.hand_type(hand)  
    case hand.chars.tally.values.sort.join
    when '5' then :five_kind
    when '14' then :four_kind
    when '23' then :full_house
    when '113' then :three_kind
    when '122' then :two_pair
    when '1112' then :one_pair
    when '11111' then :highest
    end
  end

  def self.hand_type_joker(hand)
    without_jokers = hand.delete('J')

    return hand_type(hand) if without_jokers.length == 5

    case without_jokers.chars.tally.values.sort.join
    when '', '1', '2' , '3', '4' then :five_kind
    when '11', '12', '13' then :four_kind
    when '22' then :full_house
    when '111', '112' then :three_kind
    when '1111' then :one_pair
    end
  end

  def self.hand_strength = proc do |hand|
    hand.each_char.reduce(TYPE_VALUES[hand_type(hand)]) { |acc, label| acc * 14 + LABEL_VALUES[label] }
  end

  def self.hand_strength_joker = proc do |hand|
    hand.each_char.reduce(TYPE_VALUES[hand_type_joker(hand)]) { |acc, label| acc * 14 + LABEL_VALUES_JOKER[label] }
  end

  def self._winnings(lines, &block)
    bid_strength = lines.map { |line| line.split(' ') }
                        .map! { |hand, bid| [bid.to_i, block.call(hand)] }

    bid_strength.sort { |(_, a_value), (_, b_value)| a_value <=> b_value }
                .each_with_index
                .reduce(0) { |acc, ((bid, _), i)| acc + bid * (i + 1) }
  end

  def self.winnings(lines)
    _winnings(lines, &hand_strength)
  end

  def self.winnings_jokers(lines)
    _winnings(lines, &hand_strength_joker)
  end
end
