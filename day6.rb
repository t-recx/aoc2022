def get_when_distinct(input, number_characters)
  current = input.take(number_characters)

  i = number_characters

  loop do
    current.shift
    current.push input[i]

    i += 1

    break if current.uniq.length == number_characters
  end

  return i
end

input = File.read("day6.input").chars

p get_when_distinct(input, 4)
p get_when_distinct(input, 14)
