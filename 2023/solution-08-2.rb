file = File.read("input-08.txt").split("\n\n")
moves = file[0]

map = file[1].split("\n").each_with_object({}) do |line, hash|
  node, options = line.split(" = ")
  hash[node] = options[1..-2].split(", ")
end

DIRECTIONS = %w[L R].freeze
steps = 0
positions = map.keys.select { |e| e.end_with? "A" }
solutions = Array.new(positions.size)

loop do
  direction = moves[steps % moves.size]
  steps += 1
  positions.map! { |pos| map[pos][DIRECTIONS.find_index(direction)] }

  positions.each_with_index do |position, i|
    solutions[i] = steps if solutions[i].nil? && position.end_with?("Z")
  end
  break if solutions.none?(&:nil?)
end

puts solutions.reduce(1, :lcm)
