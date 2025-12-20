grid = File.read("input-04.txt")
  .split("\n")
  .map(&:chars)

def roll?(grid, i, j)
  return false unless i >= 0 && j >= 0 && i < grid.size && j < grid.first.size

  grid[i][j] == "@"
end

c = 0
pass = 0
updated_coords = Set.new

grid.each_with_index do |row, i|
  row.each_with_index do |char, j|
    updated_coords.add([i, j]) if char == "@"
  end
end

loop do
  puts "Pass #{pass += 1}: #{updated_coords.size} positions to check. Accessible rolls so far: #{c}"
  new_grid = Marshal.load(Marshal.dump(grid))
  coords_with_rolls = updated_coords.to_a
  updated_coords.clear

  coords_with_rolls.each do |i, j|
    next unless grid[i][j] == "@"

    adjacent_rolls = [
      [i - 1, j - 1], [i - 1, j], [i - 1, j + 1],
      [i, j - 1], [i, j + 1],
      [i + 1, j - 1], [i + 1, j], [i + 1, j + 1]
    ].select { |x, y| roll?(grid, x, y) }

    next unless adjacent_rolls.size < 4

    updated_coords.merge(adjacent_rolls)
    new_grid[i][j] = "x"
    grid[i][j] = "o"
    c += 1
  end

  break if updated_coords.empty?

  grid = new_grid
end

puts "Accessible rolls: #{c}"
