require "minitest/autorun"
require_relative "../solutions/helpers"
require_relative "../solutions/17"


class TestDay17 < Minitest::Test
  EXAMPLE = %{2413432311323
3215453535623
3255245654254
3446585845452
4546657867536
1438598798454
4457876987766
3637877979653
4654967986887
4564679986453
1224686865563
2546548887735
4322674655533
}.lines.map(&:chomp)

  INPUT = get_input_lines(17)

  def test_example
    assert_equal 102, Day17.min_heat_loss(EXAMPLE)
  end

  def test_part_one
    assert_equal 1013, Day17.min_heat_loss(INPUT)    
  end

  def test_example_two
    assert_equal 94, Day17.min_heat_loss(EXAMPLE, 4, 10)
  end

  def test_part_two
    assert_equal 1215, Day17.min_heat_loss(INPUT, 4, 10)
  end
end
