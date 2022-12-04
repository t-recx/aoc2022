pairs = File.readlines("day4.input").map { |x| x.split(",").map { |y| y.split("-").map(&:to_i) }.map { |x| x[0]..x[1] } }

contains = ->(x, y) { x.include?(y.begin) && x.include?(y.end) }
overlaps = ->(x, y) { x.include?(y.begin) || x.include?(y.end) }

p pairs.count { |x| contains.call(x[0], x[1]) || contains.call(x[1], x[0]) }
p pairs.count { |x| overlaps.call(x[0], x[1]) || overlaps.call(x[1], x[0]) }
