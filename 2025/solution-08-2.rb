connected_boxes = Set.new
boxes = File.read("input-08.txt")
  .split("\n")
  .map { |line| line.split(",").map(&:to_i) }

def sqr(a1, a2)
  (a2 - a1)**2
end

distance_map = boxes.combination(2).each_with_object({}) do |((x1, y1, z1), (x2, y2, z2)), h|
  d = (sqr(x1, x2) + sqr(y1, y2) + sqr(z1, z2))**0.5
  h[d] = [[x1, y1, z1], [x2, y2, z2]]
end

distances = distance_map.keys.sort
while boxes.size > 1 && !distances.empty?
  pair = distance_map[distances.shift]

  connected_boxes.merge(pair)
  boxes.delete(pair[0])
  boxes.delete(pair[1])
end

x1 = boxes.first.first
loop do
  pair = distance_map[distances.shift]
  next unless pair.include?(boxes.first)

  x2 = pair.find { |b| b != boxes.first }.first
  puts "Multiplying last two junction boxes X coordinates: #{x1 * x2}"
  break
end
