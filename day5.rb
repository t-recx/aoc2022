input = File.read("day5.input")

def operate(crates, moves, method = ->(x) { x })
  crates_stacks = []
  crates.each do |crate|
    column = 0
    i = 1

    while i < crate.length
      crates_stacks[column] = [] unless crates_stacks[column]

      if crate[i] != " "
        crates_stacks[column].push crate[i]
      end
      i += 4
      column += 1
    end
  end

  moves.each do |move|
    number = move[1]
    start_column = move[3] - 1
    end_column = move[5] - 1

    crates_stacks[end_column].prepend *method.call(crates_stacks[start_column].take(number))
    crates_stacks[start_column] = crates_stacks[start_column][number..]
  end

  crates_stacks
end

tokens = input.split("\n\n")

crates = tokens[0].split("\n")[0..-2]
moves = tokens[1].split("\n").map { |x| x.split.map(&:to_i) }

puts operate(crates, moves, ->(x) { x.reverse }).map(&:first).join
puts operate(crates, moves).map(&:first).join
