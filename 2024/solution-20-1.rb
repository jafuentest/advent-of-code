grid = File.read("input-20.txt").split("\n").map(&:chars)

MIN_SAVE = 100
DIRECTIONS = [[-1, 0], [0, 1], [1, 0], [0, -1]].freeze
M = grid.size - 1
N = grid.first.size - 1

def dijkstra(grid, (i0, j0))
  distances = Array.new(grid.size) { Array.new(grid.first.size) { nil } }
  distances[i0][j0] = 0
  path = Set.new
  seen = Set.new
  queue = [[i0, j0]]

  until queue.empty?
    i, j = queue.shift
    next if seen.include?([i, j])

    seen.add([i, j])

    DIRECTIONS.each do |di, dj|
      i1 = i + di
      j1 = j + dj
      next if i1 < 1 || i1 >= M || j1 < 1 || j1 >= N

      if grid[i1][j1] == "#"
        distances[i1][j1] = -1
      else
        distances[i1][j1] ||= distances[i][j] + 1
        queue.push [i1, j1]
        path.add [i1, j1]
      end
    end
  end

  [distances, path]
end

start = nil
grid.each_with_index do |row, i|
  break unless start.nil?

  row.each_with_index do |cell, j|
    if cell == "S"
      start = [i, j]
      break
    end
  end
end

distances, path = dijkstra(grid, start)
cheats = 0

path.sort_by { |i, j| distances[i][j] }.each do |i, j|
  path.delete [[i, j]]

  DIRECTIONS
    .select { |di, dj| grid[i + di][j + dj] == "#" }
    .map { |di, dj| [i + (2 * di), j + (2 * dj)] }
    .select { |jump| path.include?(jump) }
    .each do |ji, jj|
      saved_time = distances[ji][jj] - distances[i][j] - 2
      cheats += 1 if saved_time >= MIN_SAVE
    end
end

puts cheats
