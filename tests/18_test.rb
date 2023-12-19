require "minitest/autorun"
require_relative "../solutions/helpers"
require_relative "../solutions/18"

class TestDay18 < Minitest::Test
  EXAMPLE = %{R 6 (#70c710)
D 5 (#0dc571)
L 2 (#5713f0)
D 2 (#d2c081)
R 2 (#59c680)
D 2 (#411b91)
L 5 (#8ceee2)
U 2 (#caa173)
L 1 (#1b58a2)
U 2 (#caa171)
R 2 (#7807d2)
U 3 (#a77fa3)
L 2 (#015232)
U 2 (#7a21e3)
}.lines.map(&:chomp)

  INPUT = get_input_lines(18)

  def test_example
    assert_equal 62, Day18.poolsize(EXAMPLE)
  end

  def test_part_one
    assert_equal 67891, Day18.poolsize(INPUT)
  end

  def test_example_part_two
    assert_equal 952408144115, Day18.large_poolsize(EXAMPLE)
  end

  def test_part_two
    assert_equal 94116351948493, Day18.large_poolsize(INPUT)
  end
end
