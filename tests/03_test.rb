require "minitest/autorun"
require_relative "../solutions/helpers"
require_relative "../solutions/03"

class TestDay03 < Minitest::Test
  def example_lines = %{467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..}.lines.map(&:chomp)

  def test_example
    assert_equal 4361, Day03.part_numbers(example_lines)
  end

  def test_example_part_two
    assert_equal 467835, Day03.gear_ratio(example_lines)
  end

  def test_part_one
    assert_equal 553825, Day03.part_numbers(get_lines(__dir__ + "/../inputs/03.txt"))
  end

  def test_part_two
    assert_equal 93994191, Day03.gear_ratio(get_lines(__dir__ + "/../inputs/03.txt"))
  end
end
