n = 50
c = 0

File.foreach("input-01.txt") do |line|
  side = line[0]
  moves = line[1..].to_i
  moves *= -1 if side == "L"
  previous_n = n
  n += moves

  if n > 0
    zeroes = n / 100
  elsif n < 0
    zeroes = (n / 100).abs
    zeroes -= 1 if previous_n == 0
    zeroes += 1 if n % 100 == 0
  else
    zeroes = 1
  end

  c += zeroes
  n %= 100
end

puts "Number of times dial passed through 0: #{c}"
