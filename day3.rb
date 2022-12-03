def get_priority(letter)
  subtraction = nil

  if letter >= "a"
    subtraction = 96
  else
    subtraction = 38
  end

  return letter.ord - subtraction
end

def part_a(input)
  sum = 0

  for i in 0..input.length - 1
    line = input[i]

    split_point = (line.length - 1) / 2

    first_compartment_letters = {}
    second_compartment_letters = {}

    common_letter = nil

    for j in 0..split_point - 1
      first_char = line[j]
      second_char = line[split_point + j]

      first_compartment_letters[first_char] = nil
      second_compartment_letters[second_char] = nil

      if first_compartment_letters.keys.include?(second_char)
        common_letter = second_char
        break
      end

      if second_compartment_letters.keys.include?(first_char)
        common_letter = first_char
        break
      end
    end

    sum += get_priority(common_letter)
  end

  return sum
end

def part_b(input)
  sum = 0
  number_elves_per_group = 3

  for i in 0..((input.length - 1) / number_elves_per_group)
    j = i * number_elves_per_group

    elves_rucksacks = input[j..j + number_elves_per_group - 1]

    elves_letters = []

    biggest_length = 0

    for k in 0..number_elves_per_group - 1
      elves_letters[k] = {}

      if elves_rucksacks[k].length > biggest_length
        biggest_length = elves_rucksacks[k].length
      end
    end

    for k in 0..biggest_length - 1
      for y in 0..number_elves_per_group - 1
        if elves_rucksacks[y][k].nil?
          next
        end

        elves_letters[y][elves_rucksacks[y][k]] = nil

        common_letter = nil

        for z in 0..number_elves_per_group - 1
          if elves_letters[z].include?(elves_rucksacks[y][k])
            common_letter = elves_rucksacks[y][k]
          else
            common_letter = nil
            break
          end
        end

        if common_letter
          break
        end
      end

      if common_letter
        break
      end
    end

    sum += get_priority(common_letter)
  end

  return sum
end

input = File.readlines("day3.input")

puts part_a(input)
puts part_b(input)
