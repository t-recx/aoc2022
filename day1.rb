elves_calories = File.read('day1.input').split("\n\n").map { |x| x.split("\n").map(&:to_i).sum }

p elves_calories.max

p elves_calories.sort[-3..].sum
