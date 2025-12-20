PRUNE = 16_777_216 # 2^24

def changes(s)
  ary = [s]
  2000.times do
    s = ((s * 64) ^ s) % PRUNE
    s = ((s / 32) ^ s) % PRUNE
    s = ((s * 2048) ^ s) % PRUNE
    ary << s
  end
  ary
end

bananas = Hash.new(0)
File.foreach("input-22.txt") do |line|
  steps = changes(line.to_i)
  delta = steps.each_cons(2).map { |x, y| (y % 10) - (x % 10) }

  seen = Set.new
  (0..(delta.size - 4)).each do |i|
    cur = delta[i, 4]
    next if seen.include?(cur)

    seen.add(cur)
    bananas[cur] += steps[i + 4] % 10
  end
end

puts bananas.values.max
