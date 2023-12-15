require "minitest/autorun"
require_relative "../solutions/helpers"
require_relative "../solutions/15"

class TestDay15 < Minitest::Test
  EXAMPLE = 'rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7'

  INPUT = get_input_lines(15).first

  def test_example
    assert_equal 1320, Day15.hash_sequence(EXAMPLE)  
  end

  def test_part_one
    assert_equal 512950, Day15.hash_sequence(INPUT)
  end

  def test_example_part_two
    assert_equal 145, Day15.hashmap_sequence(EXAMPLE)
  end

  def test_part_two
    assert_equal 247153, Day15.hashmap_sequence(INPUT)    
  end
end
