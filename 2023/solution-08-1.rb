file = File.read('input-08.txt').split("\n\n")
moves = file[0]

map = file[1].split("\n").each_with_object({}) do |line, hash|
  node, options = line.split(' = ')
  hash[node] = options[1..-2].split(', ')
end

DIRECTIONS = %w[L R].freeze
steps = 0
position = 'AAA'
loop do
  direction = moves[steps % moves.size]
  steps += 1
  position = map[position][DIRECTIONS.find_index(direction)]
  break if position == 'ZZZ'
end

puts steps
