require "minitest/autorun"
require_relative "../solutions/helpers"
require_relative "../solutions/23"

class TestDay23 < Minitest::Test
  EXAMPLE = %{#.#####################
#.......#########...###
#######.#########.#.###
###.....#.>.>.###.#.###
###v#####.#v#.###.#.###
###.>...#.#.#.....#...#
###v###.#.#.#########.#
###...#.#.#.......#...#
#####.#.#.#######.#.###
#.....#.#.#.......#...#
#.#####.#.#.#########v#
#.#...#...#...###...>.#
#.#.#v#######v###.###v#
#...#.>.#...>.>.#.###.#
#####v#.#.###v#.#.###.#
#.....#...#...#.#.#...#
#.#########.###.#.#.###
#...###...#...#...#.###
###.###.#.###v#####v###
#...#...#.#.>.>.#.>.###
#.###.###.#.###.#.#v###
#.....###...###...#...#
#####################.#
}.lines.map(&:chomp)

  INPUT = get_input_lines(23)

  def test_example
    assert_equal 94, Day23.hike(EXAMPLE)
  end

  def test_part_one
    assert_equal 2190, Day23.hike(INPUT)
  end

  def test_example_part_two
    assert_equal 154, Day23.nonslippery_hike(EXAMPLE)
  end

  # Runs in 265.11s LOL
  def test_part_two
    # skip
    assert_equal 6258,Day23.nonslippery_hike(INPUT)
  end
end
