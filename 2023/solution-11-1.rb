grid = File.read('input-11.txt')
  .split("\n")
  .map(&:chars)

(grid.first.size - 1).downto(0) do |i|
  col = grid.map { |row| row[i] }
  next if col.include?('#')

  grid.each { |row| row.insert(i, '.') }
end

(grid.size - 1).downto(0) do |i|
  next if grid[i].include?('#')

  grid.insert(i, ['.' * grid[i].size])
end

stars = []
grid.each_with_index do |row, i|
  row.each_with_index do |cell, j|
    stars << [i, j] if cell == '#'
  end
end

puts stars.combination(2).map { |(i1, j1), (i2, j2)| (i2 - i1).abs + (j2 - j1).abs }.sum
