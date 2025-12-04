grid = File.read('input-04.txt')
  .split("\n")
  .map(&:chars)

def has_roll?(grid, i, j)
  return false unless i >= 0 && j >= 0 && i < grid.size && j < grid.first.size

  grid[i][j] == "@"
end

c = 0
grid.each_with_index do |row, i|
  row.each_with_index do |char, j|
    next unless char == '@'
    coords = [
      [i - 1, j - 1], [i - 1, j], [i - 1, j + 1],
      [i, j - 1], [i, j + 1],
      [i + 1, j - 1], [i + 1, j], [i + 1, j + 1]
    ]
    if coords.count { |x, y| has_roll?(grid, x, y) } < 4
      c += 1
      grid[i][j] = 'X' if c
    end
  end
end

puts "Accessible rolls: #{c}"
