require "minitest/autorun"
require_relative "../solutions/helpers"
require_relative "../solutions/11"

class TestDay09 < Minitest::Test

  def example_lines = %{...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....
}.lines.map(&:chomp)

  def test_example
    assert_equal 374, Day11.galaxy_distances_total(example_lines)
  end

  def test_part_one
    assert_equal 9591768, Day11.galaxy_distances_total(get_lines(__dir__ + "/../inputs/11.txt"))
  end

  def test_example_part_two
    assert_equal 1030, Day11.galaxy_distances_total(example_lines, 10)
    assert_equal 8410, Day11.galaxy_distances_total(example_lines, 100)
  end

  def test_part_two
    assert_equal 746962097860, Day11.galaxy_distances_total(get_lines(__dir__ + "/../inputs/11.txt"), 1000000)
  end
end
