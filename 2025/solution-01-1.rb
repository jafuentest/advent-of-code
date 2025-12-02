n = 50
c = 0

File.foreach("input-01.txt") do |line|
  side = line[0]
  moves = line[1..].to_i
  moves *= -1 if side == "L"
  n += moves
  n %= 100

  c += 1 if n == 0
end

puts "Number of times dial returned to 0: #{c}"
