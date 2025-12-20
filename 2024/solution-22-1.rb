PRUNE = 16_777_216 # 2^24

total = 0
File.foreach("input-22.txt") do |line|
  s = line.to_i
  2000.times do
    s = ((s * 64) ^ s) % PRUNE
    s = ((s / 32) ^ s) % PRUNE
    s = ((s * 2048) ^ s) % PRUNE
  end

  total += s
end

puts total
