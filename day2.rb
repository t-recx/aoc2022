h = { 1 => { 1 => 3, 2 => 0, 3 => 6 }, 2 => { 1 => 6, 2 => 3, 3 => 0 }, 3 => { 1 => 0, 2 => 6, 3 => 3 } }
a = File.readlines('day2.input').map { |x| x.strip.split.map { |y| { 'A' => 1, 'X' => 1, 'B' => 2, 'Y' => 2, 'C' => 3, 'Z' => 3 }[y] } }
b = a.map { |x| [x[0], h[x[0]].find { |k, v| v == { 1 => 6, 2 => 3, 3 => 0 }[x[1]] }[0]] }
[a, b].each { |part| p part.map { |x| x[1] + h[x[1]][x[0]] }.sum }