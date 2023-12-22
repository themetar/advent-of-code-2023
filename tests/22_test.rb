require "minitest/autorun"
require_relative "../solutions/helpers"
require_relative "../solutions/22"

class TestDay22 < Minitest::Test
  EXAMPLE = %{1,0,1~1,2,1
0,0,2~2,0,2
0,2,3~2,2,3
0,0,4~0,2,4
2,0,5~2,2,5
0,1,6~2,1,6
1,1,8~1,1,9
}.lines.map(&:chomp)

  INPUT = get_input_lines(22)
  
  def test_example
    assert_equal 5, Day22.jenga(EXAMPLE)
  end

  def test_part_one
    assert_equal 443, Day22.jenga(INPUT)
  end

  def test_example_part_two
    assert_equal 7, Day22.destruction(EXAMPLE)
  end

  def test_part_two
    assert_equal 69915, Day22.destruction(INPUT)
  end
end
