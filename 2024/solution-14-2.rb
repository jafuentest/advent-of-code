rows = 103
cols = 101

lines = File.read('input-14.txt').split("\n").map do |line|
  match = line.match(/p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)/)
  pj, pi, vj, vi = match[1..].map(&:to_i)
  vi = rows + vi if vi < 0
  vj = cols + vj if vj < 0
  [pj, pi, vj, vi]
end

products = []
(rows * cols).times do |secs|
  totals = Array.new(4) { 0 }
  lines.each do |pj, pi, vj, vi|
    i = (pi + (vi * secs)) % rows
    j = (pj + (vj * secs)) % cols
    next if i == rows / 2 || j == cols / 2

    if i < rows / 2
      if j < cols / 2
        totals[0] += 1
      else
        totals[1] += 1
      end
    elsif j > cols / 2
      totals[3] += 1
    else
      totals[2] += 1
    end
  end

  products << totals.inject(:*)
end

secs = products.find_index(products.min)
grid = Array.new(rows) { Array.new(cols) { 0 } }
lines.each do |pj, pi, vj, vi|
  i = (pi + (vi * secs)) % rows
  j = (pj + (vj * secs)) % cols

  grid[i][j] = '#'
end

puts grid.map { |e| e.join.gsub('0', '.') }.join("\n")
puts "\nNumber of seconds to form a tree: #{secs}"
