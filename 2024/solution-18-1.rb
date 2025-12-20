coordinates = File.read("input-18.txt")
  .split("\n")
  .map { |e| e.split(",").map(&:to_i) }

T = 71
BYTES = 1024
grid = Array.new(T) { ["."] * T }

coordinates.take(BYTES).each do |j, i|
  grid[i][j] = "#"
end

M = grid.size
N = grid[0].size
DIRECTIONS = [[-1, 0], [0, 1], [1, 0], [0, -1]].freeze

distances = Array.new(grid.size) { Array.new(grid.first.size) { nil } }
distances[0][0] = 0
seen = Set.new
queue = []

queue.push([0, 0])

until queue.empty?
  i, j = queue.shift
  next if seen.include?([i, j])

  seen.add([i, j])

  DIRECTIONS.each do |di, dj|
    i1 = i + di
    j1 = j + dj
    next if i1 < 0 || i1 >= M || j1 < 0 || j1 >= N

    if grid[i1][j1] == "#"
      distances[i1][j1] = -1
    else
      distances[i1][j1] ||= distances[i][j] + 1
      queue.push [i1, j1]
    end
  end
end

puts distances[T - 1][T - 1]
