total = 0
File.foreach('input-09.txt') do |line|
  seq = line.split.map(&:to_i)
  sequences = [seq]
  until seq.all?(&:zero?)
    seq = seq[1..].map.with_index { |n, i| n - seq[i] }
    sequences << seq
  end

  total += sequences.map(&:last).sum
end

puts total
