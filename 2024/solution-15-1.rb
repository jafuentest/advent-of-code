input = File.read('input-15.txt').split("\n\n")
$grid = input[0].split("\n").map(&:chars)
$cache = {}

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

def steps_in_front(i, j, vi, vj)
  if vi == 0
    return vj > 0 ? $grid[i][j..] : $grid[i][..j].reverse
  end

  return $grid[i..].map { |e| e[j] } if vi > 0

  $grid[..i].map { |e| e[j] }.reverse
end

def pushed_boxes?(i, j, vi, vj)
  in_front = steps_in_front(i, j, vi, vj)
  return false unless in_front.include?('.')

  next_space = in_front.find_index('.')
  return false if next_space.nil?

  next_wall = in_front.find_index('#')
  return false if next_wall < next_space

  $grid[i][j] = '.'

  if vi == 0
    if vj > 0
      $grid[i][j + next_space] = 'O'
    else
      $grid[i][j - next_space] = 'O'
    end
  elsif vi > 0
    $grid[i + next_space][j] = 'O'
  else
    $grid[i - next_space][j] = 'O'
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

    next unless pushed_boxes?(ni, nj, vi, vj)

    i = ni
    j = nj
  end
end

puts $grid.map(&:join).join("\n")

total = 0
$grid.each_with_index do |row, ii|
  row.each_with_index do |cell, jj|
    total += (ii * 100) + jj if cell == 'O'
  end
end
puts total
