totals = Array.new(4) { 0 }
secs = 100
rows = 103
cols = 101

File.foreach('input-14.txt') do |line|
  match = line.match(/p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)/)
  pj, pi, vj, vi = match[1..].map(&:to_i)

  vi = rows + vi if vi < 0
  vj = cols + vj if vj < 0

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

puts totals.inject(:*)
