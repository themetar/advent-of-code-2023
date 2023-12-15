require "minitest/autorun"
require_relative "../solutions/helpers"
require_relative "../solutions/14"

class TestDay04 < Minitest::Test
  EXAMPLE_LINES =%{
O....#....
O.OO#....#
.....##...
OO.#O....O
.O.....O#.
O.#..O.#.#
..O..#O..O
.......O..
#....###..
#OO..#....
}.lines.map(&:chomp).drop(1)

  def test_prep_input
    expected = [[:round, :round, :empty, :cube,  :round, :empty, :empty, :empty, :empty, :round],
                [:empty, :round, :empty, :empty, :empty, :empty, :empty, :round, :cube, :empty]]
    
    actual = Day14.prep_input(['OO.#O....O',
                               '.O.....O#.'])

    assert_equal expected, actual
  end

  def test_example_part_one
    assert_equal 136, Day14.north_load(EXAMPLE_LINES)
  end

  def test_part_one
    assert_equal 109939, Day14.north_load(get_input_lines(14))
  end

  def test_example_part_two
    assert_equal 64, Day14.cycle_load(EXAMPLE_LINES)
  end

  def test_part_two
    assert_equal 101010, Day14.cycle_load(get_input_lines(14))
  end
end
