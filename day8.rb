def set_visibility(y, x, board, visibilities, height, width)
  visibilities[y][x] = false

  offsets = [
    [-1, 0],
    [0, -1],
    [0, 1],
    [1, 0],
  ]

  offsets.each do |oy, ox|
    nx = x + ox
    ny = y + oy
    if nx < 0 || ny < 0 || nx > width - 1 || ny > height - 1
      visibilities[y][x] = true
      break
    end
  end

  if visibilities[y][x] == false
    offsets.each do |oy, ox|
      nx = x + ox
      ny = y + oy

      if oy < 0
        visibilities[y][x] = true

        (0..y - 1).each do |vy|
          if board[vy][x] >= board[y][x]
            visibilities[y][x] = false
            break
          end
        end

        next if visibilities[y][x] == false
        break if visibilities[y][x]
      end

      if ox < 0
        visibilities[y][x] = true
        (0..x - 1).each do |vx|
          if board[y][vx] >= board[y][x]
            visibilities[y][x] = false
            break
          end
        end

        next if visibilities[y][x] == false
        break if visibilities[y][x]
      end

      if oy > 0
        visibilities[y][x] = true
        (y + 1..height - 1).each do |vy|
          if board[vy][x] >= board[y][x]
            visibilities[y][x] = false
            break
          end
        end

        next if visibilities[y][x] == false
        break if visibilities[y][x]
      end

      if ox > 0
        visibilities[y][x] = true
        (x + 1..width - 1).each do |vx|
          if board[y][vx] >= board[y][x]
            visibilities[y][x] = false
            break
          end
        end

        next if visibilities[y][x] == false
        break if visibilities[y][x]
      end
    end
  end
end

def set_scenic_score(y, x, board, scenic_score, height, width)
  score_left = 0
  score_right = 0
  score_up = 0
  score_down = 0

  (y + 1..height - 1).each do |vy|
    score_down += 1
    break if board[vy][x] >= board[y][x]
  end

  (x + 1..width - 1).each do |vx|
    score_right += 1
    break if board[y][vx] >= board[y][x]
  end

  vy = y - 1
  loop do
    break if vy < 0
    score_up += 1
    break if board[vy][x] >= board[y][x]
    vy -= 1
  end

  vx = x - 1
  loop do
    break if vx < 0
    score_left += 1
    break if board[y][vx] >= board[y][x]
    vx -= 1
  end

  scenic_score[y][x] = [score_down, score_left, score_right, score_up].reduce(&:*)
end

lines = File.readlines("day8.input").map(&:strip).map(&:chars)

board = {}
visibilities = {}
scenic_score = {}

lines.each_with_index do |line, y|
  board[y] = {}
  visibilities[y] = {}
  scenic_score[y] = {}

  line.each_with_index do |c, x|
    board[y][x] = c
    visibilities[y][x] = nil
    scenic_score[y][x] = nil
  end
end

height = lines.length
width = lines.first.length

(0..height - 1).each do |y|
  (0..width - 1).each do |x|
    set_visibility(y, x, board, visibilities, height, width)
    set_scenic_score(y, x, board, scenic_score, height, width)
  end
end

p visibilities.flat_map { |_, v| v.map { |_, vv| vv } }.count { |x| x }
p scenic_score.flat_map { |_, v| v.map { |_, vv| vv } }.max
