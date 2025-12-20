$grid = File.read("input-14.txt")
  .split("\n")
  .map(&:chars)
  .transpose
  .map(&:reverse)

$grid.each_with_index do |row, i|
  row.each_with_index do |_cell, j|
    next unless $grid[i][j] == "O"

    in_front = $grid[i][j..]

    next_space = in_front.find_index(".")
    break if next_space.nil?

    next_square_box = in_front.find_index("#")
    next if !next_square_box.nil? && (next_square_box < next_space)

    $grid[i][j] = "."
    $grid[i][j + next_space] = "O"
  end
end

total = $grid.reduce(0) do |sum, row|
  sum + row.each_with_index.reduce(0) do |row_sum, (cell, j)|
    row_sum + (cell == "O" ? j + 1 : 0)
  end
end

puts total
