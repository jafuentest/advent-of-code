def find_symmetry_point(arr)
  m = arr.size / 2

  m.times do |i|
    return i + 1 if arr[0, i + 1] == arr[i + 1, i + 1].reverse
  end

  m.times do |i|
    diff = i + 1
    j = arr.size - diff
    j2 = arr.size - (diff * 2)
    return j if arr[j..] == arr[j2, i + 1].reverse
  end

  0
end

t = 0
File.read('input-13.txt').split("\n\n").each do |input|
  rows = input.split("\n")
  cols = rows.first.size.times.map do |i|
    rows.map { |row| row[i] }.join
  end

  symmetric_rows = find_symmetry_point(rows)
  symmetric_cols = find_symmetry_point(cols)

  t += (symmetric_rows * 100) + symmetric_cols
end

puts t
