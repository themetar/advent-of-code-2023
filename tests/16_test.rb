require "minitest/autorun"
require_relative "../solutions/helpers"
require_relative "../solutions/16"

class TestDay16 < Minitest::Test
  EXAMPLE = %{.|...\\....
|.-.\\.....
.....|-...
........|.
..........
.........\\
..../.\\\\..
.-.-/..|..
.|....-|.\\
..//.|....
}.lines.map(&:chomp)

  INPUT = get_input_lines(16)

  def test_example
    assert_equal 46, Day16.energized_count(EXAMPLE)
  end

  def test_part_one
    assert_equal 7210, Day16.energized_count(INPUT)
  end

  def test_example_part_two
    assert_equal 51, Day16.find_best(EXAMPLE)
  end

  def test_part_two
    assert_equal 7673, Day16.find_best(INPUT)
  end
end
