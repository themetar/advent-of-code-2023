require "minitest/autorun"
require_relative "../solutions/helpers"
require_relative "../solutions/05"

class TestDay04 < Minitest::Test
  def example_lines = %{seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4
}.lines.map(&:chomp)

  def test_example
    assert_equal 35, Day05.min_location(example_lines)
  end

  def test_part_one
    assert_equal 3374647, Day05.min_location(get_lines(__dir__ + "/../inputs/05.txt"))
  end

  def test_example_part_two
    assert_equal 46, Day05.min_location_ranges(example_lines)
  end

  def test_part_two
    assert_equal 6082852, Day05.min_location_ranges(get_lines(__dir__ + "/../inputs/05.txt"))
  end
end
