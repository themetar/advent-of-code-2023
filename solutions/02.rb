module Day02
  def self.games(lines)
    cond = {"red" => 12, "green" => 13, "blue" => 14}

    lines.reduce(0) do |acc, line|
      game_info, draws = line.split(':')
      game_no = game_info[/\d+/].to_i

      draws.scan(/(\d+) (red|green|blue)/).all? { |count, color| count.to_i <= cond[color] } ? acc + game_no : acc
    end
  end

  def self.games_2(lines)
    lines.reduce(0) do |acc, line|
      _, draws = line.split(':')

      acc + draws.scan(/(\d+) (red|green|blue)/).each.with_object(Hash.new(0)) do |(count, color), min_cubes|
        count = count.to_i
        min_cubes[color] = min_cubes[color] > count ? min_cubes[color] : count
      end
        .values.reduce(&:*)
    end
  end
end
