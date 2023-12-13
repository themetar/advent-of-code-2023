require "minitest/autorun"
require_relative "../solutions/helpers"
require_relative "../solutions/12"

class TestDay12 < Minitest::Test
  def example_lines = %{???.### 1,1,3
.??..??...?##. 1,1,3
?#?#?#?#?#?#?#? 1,3,1,6
????.#...#... 4,1,1
????.######..#####. 1,6,5
?###???????? 3,2,1
}.lines.map(&:chomp)

  def test_possible_arrangements
    assert_equal 4, Day12.possible_arrangements('.??..??...?##.', [1,1,3])
  end

  def test_example
    # skip
    assert_equal 21, Day12.broken_springs(example_lines)
  end

  def test_part_one
    assert_equal 7361, Day12.broken_springs(get_lines(__dir__ + "/../inputs/12.txt"))
  end
end
