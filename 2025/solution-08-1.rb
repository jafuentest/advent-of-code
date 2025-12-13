circuits = []
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
c = 0
while c < 1000 && !distances.empty?
  pair = distance_map[distances.shift]
  c += 1

  if (existing_circuits = circuits.select { |c| c.include?(pair[0]) || c.include?(pair[1]) }).empty?
    circuits << Set.new(pair)
    next
  end

  if existing_circuits.size == 1
    existing_circuit = existing_circuits.first

    # Both junctions are already in the circuit
    next if existing_circuit.include?(pair[0]) && existing_circuit.include?(pair[1])

    existing_circuit.merge(pair)
  else
    existing_circuits.first.merge(existing_circuits.last).merge(pair)
    circuits.delete(existing_circuits.last)
  end
end

puts "Multiplying largest circuits sizes: #{circuits.map(&:size).sort.last(3).reduce(:*)}"
