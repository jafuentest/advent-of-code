require 'algorithms'

grid = File.read('input-16.txt')
  .split("\n")
  .map(&:chars)

m = grid.size
n = grid[0].size
DIRECTIONS = [[-1, 0], [0, 1], [1, 0], [0, -1]].freeze

i0 = j0 = it = jt = nil

grid.each_with_index do |row, i|
  row.each_with_index do |cell, j|
    if cell == 'S'
      i0 = i
      j0 = j
    elsif cell == 'E'
      it = i
      jt = j
    end
  end
end

p_queue = Containers::PriorityQueue.new
seen = Set.new

p_queue.push([0, i0, j0, 1], 0)
distances = {}
best = nil

until p_queue.empty?
  d, i, j, dir = p_queue.pop

  distances[[i, j, dir]] = d unless distances.key?([i, j, dir])

  best = d if i == it && j == jt && best.nil?

  next if seen.include?([i, j, dir])

  seen.add([i, j, dir])
  di, dj = DIRECTIONS[dir]
  i1 = i + di
  j1 = j + dj

  if i1 >= 0 && i1 < m && j1 >= 0 && j1 < n && grid[i1][j1] != '#'
    p_queue.push([d + 1, i1, j1, dir], (-1 - d))
  end

  p_queue.push([d + 1000, i, j, (dir + 1) % 4], (-1000 - d))
  p_queue.push([d + 1000, i, j, (dir + 3) % 4], (-1000 - d))
end

puts best

p_queue = Containers::PriorityQueue.new
seen = Set.new

4.times { |dir1| p_queue.push([0, it, jt, dir1], 0) }
distances2 = {}

until p_queue.empty?
  d, i, j, dir = p_queue.pop

  distances2[[i, j, dir]] = d unless distances2.key?([i, j, dir])

  next if seen.include?([i, j, dir])

  seen.add([i, j, dir])

  di, dj = DIRECTIONS[(dir + 2) % 4]
  i1 = i + di
  j1 = j + dj

  if i1 >= 0 && i1 < m && j1 >= 0 && j1 < n && grid[i1][j1] != '#'
    p_queue.push([d + 1, i1, j1, dir], (-1 - d))
  end

  p_queue.push([d + 1000, i, j, (dir + 1) % 4], (-1000 - d))
  p_queue.push([d + 1000, i, j, (dir + 3) % 4], (-1000 - d))
end

walked = Set.new

grid.each_with_index do |row, ii|
  row.each_index do |jj|
    4.times do |dir1|
      next unless distances.key?([ii, jj, dir1]) && distances2.key?([ii, jj, dir1])

      walked.add([ii, jj]) if distances[[ii, jj, dir1]] + distances2[[ii, jj, dir1]] == best
    end
  end
end

puts walked.size
