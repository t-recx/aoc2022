instructions = File.readlines("day10.input").map { |line| line.split }

i = 0
cycle = 1
x = 1

cycles_to_complete = { "addx" => 2, "noop" => 1 }
cycles_to_next_instruction = 0

signal_strength_collection_points = [20, 60, 100, 140, 180, 220]
signal_strengths = []

instruction = nil
value = nil

width = 40
height = 6

display = []

height.times do
  display.push Array.new(width, ".")
end

loop do
  current_x = (cycle - 1) % (width)

  if current_x >= x - 1 && current_x <= x + 1
    display[(cycle - 1) / width][current_x] = "#"
  end

  if cycles_to_next_instruction == 0
    instruction, value = instructions[i]

    break if instruction.nil?

    cycles_to_next_instruction = cycles_to_complete[instruction]
  end

  cycle += 1
  cycles_to_next_instruction -= 1

  if cycles_to_next_instruction == 0
    x += value.to_i if value
    i += 1
  end

  if signal_strength_collection_points.include? cycle
    signal_strengths.push cycle * x
  end
end

p signal_strengths.sum

display.each do |line|
  p line.join
end
