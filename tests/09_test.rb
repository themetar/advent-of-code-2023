require "minitest/autorun"
require_relative "../solutions/helpers"
require_relative "../solutions/09"

class TestDay09 < Minitest::Test

  def example_lines = %{0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45
}.lines.map(&:chomp)

  def test_example
    assert_equal 114, Day09.extrapolated_vals(example_lines)
  end

  def test_part_one
    assert_equal 2008960228, Day09.extrapolated_vals(get_lines(__dir__ + "/../inputs/09.txt"))
  end

  def test_example_part_two
    assert_equal 2, Day09.extrapolated_vals_rev(example_lines)
  end

  def test_part_two
    assert_equal 1097, Day09.extrapolated_vals_rev(get_lines(__dir__ + "/../inputs/09.txt"))
  end
end
