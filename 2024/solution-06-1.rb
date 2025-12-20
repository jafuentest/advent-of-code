i = j = nil
dir = 0
directions = [
  [-1, 0],
  [0, 1],
  [1, 0],
  [0, -1]
]

grid = File.read("input-06.txt")
  .split("\n")
  .map(&:chars)

grid.each_with_index do |row, row_index|
  col_index = row.index("^")
  next unless col_index

  i = row_index
  j = col_index
  break
end

loop do
  grid[i][j] = "X"
  i += directions[dir][0]
  j += directions[dir][1]

  break if i < 0 || j < 0 || i >= grid.size || j >= grid.size

  next unless grid[i][j] == "#"

  i -= directions[dir][0]
  j -= directions[dir][1]
  dir = (dir + 1) % 4
end

puts grid.map { |e| e.count { |c| c == "X" } }.sum
