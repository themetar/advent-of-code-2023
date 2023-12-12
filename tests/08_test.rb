require "minitest/autorun"
require_relative "../solutions/helpers"
require_relative "../solutions/08"

class TestDay08 < Minitest::Test

  def example_lines = %{RL

AAA = (BBB, CCC)
BBB = (DDD, EEE)
CCC = (ZZZ, GGG)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)
}.lines.map(&:chomp)


def example_lines_part_two = %{LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)
}.lines.map(&:chomp)

  def test_example
    assert_equal 2, Day08.steps(example_lines)
  end

  def test_part_one
    assert_equal 24253, Day08.steps(get_lines(__dir__ + "/../inputs/08.txt"))
  end

  def test_example_part_two
    assert_equal 6, Day08.az_steps(example_lines_part_two)
  end

  def test_part_two
    assert_equal 12357789728873, Day08.az_steps(get_lines(__dir__ + "/../inputs/08.txt"))
  end
end
