grid = File.read("input-11.txt")
  .split("\n")
  .map(&:chars)

stars = []
starred_rows = Set.new
starred_cols = Set.new
grid.each_with_index do |row, i|
  row.each_with_index do |cell, j|
    if cell == "#"
      starred_rows.add(i)
      starred_cols.add(j)
      stars << [i, j]
    end
    grid[i][j] = 1
  end
end

EXPANSION_RATE = 1_000_000

(grid.first.size - 1).downto(0) do |i|
  next if starred_cols.include? i

  grid.each { |row| row[i] = EXPANSION_RATE }
end

(grid.size - 1).downto(0) do |i|
  next if starred_rows.include? i

  grid[i] = [EXPANSION_RATE] * grid[i].size
end

def distance(grid, s1, s2)
  row = grid[s1[0]]
  col = grid.map { |r| r[s1[1]] }

  di = (s2[1] - s1[1]).abs - 1
  dj = (s2[0] - s1[0]).abs - 1

  left = [s2[1], s1[1]].min + 1
  top = [s2[0], s1[0]].min + 1

  distance_i = di < 0 ? 0 : row[left, di].sum + 1
  distance_j = dj < 0 ? 0 : col[top, dj].sum + 1
  distance_i + distance_j
end

puts stars.combination(2).map { |s1, s2| distance(grid, s1, s2) }.sum
