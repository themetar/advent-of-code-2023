require "minitest/autorun"
require_relative "../solutions/helpers"
require_relative "../solutions/10"

class TestDay10 < Minitest::Test
  
  def example_lines = %{-L|F7
7S-7|
L|7||
-L-J|
L|-JF
}.lines.map(&:chomp)

def example_lines_2 = %{7-F7-
.FJ|7
SJLL7
|F--J
LJ.LJ
}.lines.map(&:chomp)

def example_lines_part_2 = %{..........
.S------7.
.|F----7|.
.||....||.
.||....||.
.|L-7F-J|.
.|..||..|.
.L--JL--J.
..........}.lines.map(&:chomp)

def example_lines_part_2_2 = %{FF7FSF7F7F7F7F7F---7
L|LJ||||||||||||F--J
FL-7LJLJ||||||LJL-77
F--JF--7||LJLJIF7FJ-
L---JF-JLJIIIIFJLJJ7
|F|F-JF---7IIIL7L|7|
|FFJF7L7F-JF7IIL---7
7-L-JL7||F7|L7F-7F7|
L.L7LFJ|||||FJL7||LJ
L7JLJL-JLJLJL--JLJ.L}.lines.map(&:chomp)

  def test_example
    assert_equal 4, Day10.max_distance(example_lines)
  end

  def test_example_2
    assert_equal 8, Day10.max_distance(example_lines_2)
  end

  def test_part_one
    assert_equal 7093, Day10.max_distance(get_lines(__dir__ + "/../inputs/10.txt"))
  end

  def test_example_part_two
    assert_equal 4, Day10.inloop_tiles(example_lines_part_2)
  end

  def test_example_part_two_2
    assert_equal 10, Day10.inloop_tiles(example_lines_part_2_2)
  end

  def test_part_two
    assert_equal 407, Day10.inloop_tiles(get_lines(__dir__ + "/../inputs/10.txt"))
  end
end
