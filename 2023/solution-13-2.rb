def find_symmetry_point(arr)
  m = arr.size / 2

  m.times do |i|
    left = arr[0, i + 1].join.chars
    right = arr[i + 1, i + 1].reverse.join.chars

    return i + 1 if left.zip(right).count { |e1, e2| e1 != e2 } == 1
  end

  m.times do |i|
    diff = i + 1
    j = arr.size - diff
    j2 = arr.size - (diff * 2)

    left = arr[j..].join.chars
    right = arr[j2, i + 1].reverse.join.chars

    return j if left.zip(right).count { |e1, e2| e1 != e2 } == 1
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
