max = -1
data = Hash.new { |h, k| h[k] = [] }
File.foreach("input-08.txt") do |line|
  max += 1
  line.chars.each_with_index do |char, j|
    data[char] << [max, j] unless [".", "\n"].include?(char)
  end
end

points = Set.new
data.each_value do |coords|
  next if coords.size < 2

  coords.combination(2).each do |a, b|
    points.add(a)
    points.add(b)
    aa = a.dup
    bb = b.dup

    dx = b[0] - a[0]
    dy = b[1] - a[1]

    loop do
      c = [a[0] - dx, a[1] - dy]
      a = c.dup
      break unless c.all? { |e| e.between?(0, max) }

      points.add(c)
    end

    a = aa
    b = bb

    loop do
      c = [b[0] + dx, b[1] + dy]
      b = c.dup
      break unless c.all? { |e| e.between?(0, max) }

      points.add(c)
    end
  end
end

puts points.size
