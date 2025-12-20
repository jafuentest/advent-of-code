grid = File.read("input-10.txt")
  .split("\n")
  .map { |e| e.chars.map(&:to_i) }

starts = []
grid.each_with_index do |row, i|
  row.each_with_index do |c, j|
    starts << [i, j] if c == 0
  end
end

STEPS = [[0, -1], [-1, 0], [0, 1], [1, 0]].freeze

def trails_length_from(grid, i, j)
  next_steps = STEPS.map { |x, y| [i + x, j + y] }
    .select do |ni, nj|
      ni >= 0 && nj >= 0 && ni < grid.size && nj < grid.size && grid[ni][nj] - grid[i][j] == 1
    end

  return next_steps if grid[i][j] == 8

  next_steps.reduce([]) { |trails, (ni, nj)| trails + trails_length_from(grid, ni, nj) }.uniq
end

puts starts.map { |i, j| trails_length_from(grid, i, j).size }.sum
