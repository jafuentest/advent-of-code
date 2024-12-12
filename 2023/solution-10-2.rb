STEPS = [[-1, 0], [0, -1], [0, 1], [1, 0]].freeze

grid = File.read('input-10.txt')
  .split("\n")
  .map(&:chars)

def find_s(grid)
  grid.each_with_index do |row, i|
    row.each_with_index { |char, j| return [i, j] if char == 'S' }
  end
end

def find_starts(grid)
  i0, j0 = find_s(grid)
  STEPS.map { |x, y| [i0 + x, j0 + y] }.select do |i, j|
    next_section?(grid, i0, j0, i, j)
  end
end

def replace_start(grid, i1, j1, i2, j2)
  i, j = find_s(grid)
  s1 = STEPS.find_index([i1 - i, j1 - j])
  s2 = STEPS.find_index([i2 - i, j2 - j])
  s1, s2 = s2, s1 if s1 > s2

  if s1 == 0
    if s2 == 1
      'J'
    else
      s2 == 2 ? 'L' : '|'
    end
  elsif s1 == 1
    s2 == 2 ? '-' : '7'
  else
    'F'
  end
end

def next_section?(grid, i1, j1, i2, j2)
  return false unless i2 >= 0 && j2 >= 0 && i2 < grid.size && j2 < grid.first.size

  char1 = grid[i1][j1]
  char2 = grid[i2][j2]
  d = [i2 - i1, j2 - j1]

  return false if char2 == '.' || char2.is_a?(Integer)

  (d == [0, 1]  && %w[- L F S].include?(char1) && %w[- J 7].include?(char2)) ||
  (d == [0, -1] && %w[- J 7 S].include?(char1) && %w[- L F].include?(char2)) ||
  (d == [1, 0]  && %w[| 7 F S].include?(char1) && %w[| L J].include?(char2)) ||
  (d == [-1, 0] && %w[| L J S].include?(char1) && %w[| 7 F].include?(char2))
end

new_grid = Array.new(grid.size) { Array.new(grid.first.size) { '.' } }
next1, next2 = find_starts(grid)

i1, j1 = next1
i2, j2 = next2
n = 1

i0, j0 = find_s(grid)
new_grid[i0][j0] = replace_start(grid, i1, j1, i2, j2)

until next1 == next2
  next1 = STEPS.map { |x, y| [i1 + x, j1 + y] }
    .find { |i, j| next_section?(grid, i1, j1, i, j) }

  next2 = STEPS.map { |x, y| [i2 + x, j2 + y] }
    .find { |i, j| next_section?(grid, i2, j2, i, j) }

  new_grid[i1][j1] = grid[i1][j1]
  new_grid[i2][j2] = grid[i2][j2]

  grid[i1][j1] = n
  grid[i2][j2] = n
  n += 1

  i1, j1 = next1
  i2, j2 = next2
end

new_grid[i1][j1] = grid[i1][j1]
new_grid[i2][j2] = grid[i2][j2]

count = 0
new_grid.each do |row|
  row.each_with_index do |cell, j|
    next unless %w[. i].include?(cell)

    ray = row[j + 1..]

    pipes = ray.select { |e| e == '|' }.size
    corners1 = ray.select { |e| %w[L 7].include?(e) }.size
    corners2 = ray.select { |e| %w[F J].include?(e) }.size

    if (pipes + (corners1 / 2) - (corners2 / 2)) % 2 > 0
      count += 1
      row[j] = '.'
    else
      row[j] = ' '
    end
  end
end

puts count
