ranges = File.read("input-05.txt").split("\n\n").first
  .split("\n")
  .map { |line| Range.new(*line.split("-").map(&:to_i)) }
  .sort_by(&:first)

i = 0
while i < ranges.size
  range = ranges[i]
  j = i + 1

  while j < ranges.size
    other_range = ranges[j]
    break if other_range.first > range.last

    new_max = [range.last, other_range.last].max
    range = ranges[i] = (range.first..new_max)
    ranges.delete_at(j)
  end

  i += 1
end

puts ranges.reduce(0) { |sum, r| sum + (r.last - r.first + 1) }
