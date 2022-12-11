def touching(a, b)
  if a[0] != b[0] && a[1] != b[1] && ((a[0] - b[0]).abs + (a[1] - b[1]).abs) > 2
    return false
  elsif a[0] == b[0] && (a[1] - b[1]).abs > 1
    return false
  elsif a[1] == b[1] && (a[0] - b[0]).abs > 1
    return false
  end

  return true
end

# todo create a knot class with pos, visited and initialize for part B

instructions = File.readlines("day9.input").map(&:split).map { |x| [x[0], x[1].to_i] }

hpos = [0, 0]
tpos = [0, 0]
move = [0, 0]
visited = {}
initialized = false

instructions.each do |direction, steps|
  if direction == "R"
    move = [1, 0]
  elsif direction == "L"
    move = [-1, 0]
  elsif direction == "D"
    move = [0, 1]
  else
    move = [0, -1]
  end

  steps.times do |step|
    prev_hpos = hpos.dup

    hpos = [hpos[0] + move[0], hpos[1] + move[1]]

    if !initialized
      tpos = prev_hpos
      initialized = true
    end

    unless touching(tpos, hpos)
      tpos = prev_hpos
    end

    visited[tpos.join(",")] = true
  end
end

p visited.keys.length
