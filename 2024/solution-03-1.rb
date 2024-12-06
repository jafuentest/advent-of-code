regex = /mul\((\d+),\s*(\d+)\)/

instructions = File.read('input-03.txt')
  .scan(regex)
  .map { |x, y| x.to_i * y.to_i }

puts instructions.sum
