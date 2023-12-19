require "minitest/autorun"
require_relative "../solutions/helpers"
require_relative "../solutions/19"

class TestDay19 < Minitest::Test
  EXAMPLE = %{px{a<2006:qkq,m>2090:A,rfg}
pv{a>1716:R,A}
lnx{m>1548:A,A}
rfg{s<537:gd,x>2440:R,A}
qs{s>3448:A,lnx}
qkq{x<1416:A,crn}
crn{x>2662:A,R}
in{s<1351:px,qqz}
qqz{s>2770:qs,m<1801:hdj,R}
gd{a>3333:R,R}
hdj{m>838:A,pv}

{x=787,m=2655,a=1222,s=2876}
{x=1679,m=44,a=2067,s=496}
{x=2036,m=264,a=79,s=2244}
{x=2461,m=1339,a=466,s=291}
{x=2127,m=1623,a=2188,s=1013}
}.lines.map(&:chomp)

  INPUT = get_input_lines(19)

  def test_example
    assert_equal 19114, Day19.process_parts(EXAMPLE)
  end

  def test_part_one
    assert_equal 333263, Day19.process_parts(INPUT)
  end

  def test_example_part_two
    assert_equal 167409079868000, Day19.acceptable_combinations(EXAMPLE)
  end

  def test_part_two
    assert_equal 130745440937650, Day19.acceptable_combinations(INPUT)
  end
end
