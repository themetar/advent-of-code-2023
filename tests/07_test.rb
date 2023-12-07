require "minitest/autorun"
require_relative "../solutions/helpers"
require_relative "../solutions/07"

class TestDay07 < Minitest::Test
  def test_hand_type
    hands = %w{KKKKK 39333 KJKKJ 52242 62464 7A95A 36Q2T} # non-exaustive
    types = %i{five_kind four_kind full_house three_kind two_pair one_pair highest}

    hands.zip(types).each do |h, t|
      assert_equal t, Day07.hand_type(h), "#{h} is not #{t}"
    end
  end

  def example_lines = %{32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
}.lines.map(&:chomp)

  def test_example
    assert_equal 6440, Day07.winnings(example_lines)
  end

  def test_part_one
    assert_equal 249726565, Day07.winnings(get_lines(__dir__ + "/../inputs/07.txt"))
  end

  def test_example_part_two
    assert_equal 5905, Day07.winnings_jokers(example_lines)
  end

  def test_part_two
    assert_equal 251135960, Day07.winnings_jokers(get_lines(__dir__ + "/../inputs/07.txt"))
  end
end
