points = []
lines = File.read('input-04.txt').split("\n")

lines.each do |line|
  split_line = line.split('|')
  winning_numbers = split_line.first.scan(/\d+/)[1..]
  owned_numbers = split_line.last.scan(/\d+/)

  matched_numbers = winning_numbers & owned_numbers
  next unless matched_numbers.any?

  points << (2**(matched_numbers.size - 1))
end

puts points.sum
