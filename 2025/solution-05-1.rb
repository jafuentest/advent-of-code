input = File.read("input-05.txt").split("\n\n")
ranges = input.first
  .split("\n")
  .map { |line| Range.new(*line.split("-").map(&:to_i)) }
  .sort_by(&:first)

c = 0

input.last.split("\n").count do |line|
  n = line.to_i

  c += 1 if ranges.select { |r| r.first <= n }.any? { |r| r.include?(n) }
end

puts "Number of fresh ingredients: #{c}"
