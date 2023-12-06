require "minitest/autorun"
require_relative "../solutions/helpers"
require_relative "../solutions/06"

class TestDay06 < Minitest::Test

  def example_lines = %{Time:      7  15   30
Distance:  9  40  200}.lines.map(&:chomp)

  def my_example = %{Time: 10
Distance: 30}.lines.map(&:chomp)

  def test_example
    assert_equal 288, Day06.race_margin(example_lines)
  end

  def test_part_one
    assert_equal 449820, Day06.race_margin(get_lines(__dir__ + "/../inputs/06.txt"))
  end

  def test_example_part_two
    assert_equal 71503, Day06.single_race(example_lines)
  end

  def test_part_two
    assert_equal 42250895, Day06.single_race(get_lines(__dir__ + "/../inputs/06.txt"))
  end

  def test_unbeatable_race_margin
    assert_equal 0, Day06.race_margin(my_example)
  end

  def test_unbeatable_single
    assert_equal 0, Day06.single_race(my_example)
  end
end
