max = -1
data = Hash.new { |h, k| h[k] = [] }
File.foreach("input-08.txt") do |line|
  max += 1
  line.chars.each_with_index do |char, j|
    data[char] << [max, j] unless char == "."
  end
end

points = Set.new
data.each_value do |coords|
  coords.combination(2).each do |a, b|
    dx = b[0] - a[0]
    dy = b[1] - a[1]

    c1 = [a[0] - dx, a[1] - dy]
    c2 = [b[0] + dx, b[1] + dy]

    [c1, c2].each do |c|
      points.add(c) if c.all? { |e| e.between?(0, max) }
    end
  end
end

puts points.size
