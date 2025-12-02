inputs = File.read('input-25.txt').split("\n\n").map { |e| e.split("\n") }
keys = []
locks = []

def grid_to_int(grid)
  ary = Array.new(grid.first.size)
  char = grid.first[0]

  grid[1..].each_with_index do |row, n|
    row.chars.each_with_index do |cell, i|
      ary[i] ||= n if cell != char
    end
  end

  ary
end

inputs.each do |input|
  if input.first[0] == '.'
    keys << grid_to_int(input)
  else
    locks << grid_to_int(input)
  end
end

total = locks.reduce(0) do |count, lock|
  count + keys.count do |key|
    lock.zip(key).none? { |l, k| l > k }
  end
end

puts total
