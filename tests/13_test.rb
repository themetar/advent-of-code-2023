require "minitest/autorun"
require_relative "../solutions/helpers"
require_relative "../solutions/13"

class TestDay13 < Minitest::Test
  def example_lines = %{#.##..##.
..#.##.#.
##......#
##......#
..#.##.#.
..##..##.
#.#.##.#.

#...##..#
#....#..#
..##..###
#####.##.
#####.##.
..##..###
#....#..#
}.lines.map(&:chomp)

  def setup
    @input = get_lines(__dir__ + '/../inputs/13.txt')
  end

  def test_example
    assert_equal 405, Day13.mirror_count(example_lines)
  end

  def test_part_one
    assert_equal 30705, Day13.mirror_count(@input)
  end

  def test_example_part_two
    assert_equal 400, Day13.mirror_count_smudge(example_lines)
  end

  def test_part_two
    assert_equal 44615, Day13.mirror_count_smudge(@input)
  end
end

