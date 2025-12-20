def line_to_number(line)
  numbers = line.chars.select { |e| e.to_i.to_s == e }
  (numbers.first + numbers.last).to_i
end

puts File.read("input-01.txt")
  .split("\n")
  .map { |e| line_to_number(e) }
  .reduce(0) { |total, e| total + e }
