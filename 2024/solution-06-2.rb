def will_loop?(grid, i, j)
  visited = Set.new
  dir = 0
  directions = [[-1, 0], [0, 1], [1, 0], [0, -1]]
  loop do
    return true if visited.include? [i, j, dir]

    visited.add [i, j, dir]
    i += directions[dir][0]
    j += directions[dir][1]

    return false if i < 0 || j < 0 || i >= grid.size || j >= grid.size
    next unless grid[i][j] == '#'

    i -= directions[dir][0]
    j -= directions[dir][1]
    dir = (dir + 1) % 4
  end
end

i = j = nil

grid = File.read('input-06.txt')
  .split("\n")
  .map(&:chars)

grid.each_with_index do |row, row_index|
  col_index = row.index('^')
  next unless col_index

  i = row_index
  j = col_index
  grid[i][j] = '.'
  break
end

i0 = i
j0 = j
directions = [[-1, 0], [0, 1], [1, 0], [0, -1]]
dir = 0
count = 0
visited = Set.new
loop do
  unless visited.include? [i, j]
    temp_grid = grid.map(&:dup)
    temp_grid[i][j] = '#'
    count += 1 if will_loop?(temp_grid, i0, j0)
  end

  visited.add [i, j]
  i += directions[dir][0]
  j += directions[dir][1]

  break if i < 0 || j < 0 || i >= grid.size || j >= grid.size
  next unless grid[i][j] == '#'

  i -= directions[dir][0]
  j -= directions[dir][1]
  dir = (dir + 1) % 4
end

puts count
