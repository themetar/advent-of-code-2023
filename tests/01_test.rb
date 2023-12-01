require "minitest/autorun"
require_relative "../solutions/helpers"
require_relative "../solutions/01"

class TestDay01 < Minitest::Test
  def test_part_one
    assert_equal 54940, Day01.calibration_sum_digits(get_lines(__dir__ + "/../inputs/01.txt"))
  end

  def test_part_two
    assert_equal 54208, Day01.calibration_sum_all(get_lines(__dir__ + "/../inputs/01.txt"))
  end
end
