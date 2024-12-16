input = File.read('input-15.txt').split("\n\n")
$grid = []
input[0].split("\n").each do |row|
  grid_row = []
  row.chars.each do |char|
    case char
    when '.'
      grid_row << '.'
      grid_row << '.'
    when 'O'
      grid_row << '['
      grid_row << ']'
    when '#'
      grid_row << '#'
      grid_row << '#'
    else
      grid_row << '@'
      grid_row << '.'
    end
  end
  $grid << grid_row
end

DIRECTIONS = {
  '>' => [0, 1],
  'v' => [1, 0],
  '<' => [0, -1],
  '^' => [-1, 0]
}.freeze

pos = [$grid.find_index { |e| e.include? '@' }]
pos << $grid[pos[0]].find_index { |e| e.include? '@' }
i, j = pos
$grid[i][j] = '.'

def pushed_boxes?(i, j, vi, vj)
  queue = [[i, j]]
  seen = Set.new
  pushed_boxes = true

  until queue.empty?
    i, j = queue.shift
    next if seen.include? [i, j]

    seen.add [i, j]
    ni = i + vi
    nj = j + vj

    case $grid[ni][nj]
    when '#'
      pushed_boxes = false
      break
    when '['
      queue << [ni, nj]
      queue << [ni, nj + 1]
    when ']'
      queue << [ni, nj]
      queue << [ni, nj - 1]
    end
  end

  return false unless pushed_boxes

  until seen.empty?
    seen.sort.each do |i1, j1|
      i2 = i1 + vi
      j2 = j1 + vj
      next if seen.include? [i2, j2]

      $grid[i2][j2] = $grid[i1][j1]
      $grid[i1][j1] = '.'
      seen.delete [i1, j1]
    end
  end

  true
end

input[1].split("\n").each do |moves_line|
  moves_line.chars.each do |move|
    vi, vj = DIRECTIONS[move]
    ni = i + vi
    nj = j + vj

    next if $grid[ni][nj] == '#'

    if $grid[ni][nj] == '.'
      i = ni
      j = nj
      next
    end

    next unless pushed_boxes?(i, j, vi, vj)

    i = ni
    j = nj
  end
end

total = 0
$grid.each_with_index do |row, ii|
  row.each_with_index do |cell, jj|
    total += (ii * 100) + jj if cell == '['
  end
end

puts $grid.map(&:join).join("\n")
puts total
