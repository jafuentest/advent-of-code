grid = File.read('input-20.txt').split("\n").map(&:chars)

MIN_SAVE = 100
CHEAT_TIME = 20
M = grid.size - 1
N = grid.first.size - 1
DIRECTIONS = (-CHEAT_TIME..CHEAT_TIME).each_with_object([]) do |i, result|
  (-CHEAT_TIME..CHEAT_TIME).each do |j|
    result << [i, j] if i.abs + j.abs <= CHEAT_TIME
  end
end

def dijkstra(grid, s)
  directions = [[-1, 0], [0, 1], [1, 0], [0, -1]].freeze
  i0, j0 = s
  distances = Array.new(grid.size) { Array.new(grid.first.size) { nil } }
  distances[i0][j0] = 0
  path = Set.new
  seen = Set.new
  queue = [[i0, j0]]

  until queue.empty?
    i, j = queue.shift
    next if seen.include?([i, j])

    seen.add([i, j])

    directions.each do |di, dj|
      i1 = i + di
      j1 = j + dj
      next if i1 < 1 || i1 >= M || j1 < 1 || j1 >= N

      if grid[i1][j1] == '#'
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
    if cell == 'S'
      start = [i, j]
      break
    end
  end
end

distances, path = dijkstra(grid, start)
sorted_path = path.sort_by { |i, j| distances[i][j] }
cheats = 0

sorted_path.each do |i, j|
  path.delete [[i, j]]

  DIRECTIONS
    .map { |di, dj| [i + di, j + dj] }
    .select { |jump| path.include?(jump) }
    .each do |ji, jj|
      md = (ji - i).abs + (jj - j).abs
      saved_time = distances[ji][jj] - distances[i][j] - md

      cheats += 1 if saved_time >= MIN_SAVE
    end
end

puts cheats
