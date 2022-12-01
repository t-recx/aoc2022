elves_calories = File.readlines('day1.input').map(&:strip).chunk(&:empty?).reject(&:first).map(&:last).map { |x| x.map(&:to_i) }.map(&:sum)

p elves_calories.max

p elves_calories.sort[-3..].sum
