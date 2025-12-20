max_area = File.read("input-09.txt")
  .split("\n")
  .map { |line| line.split(",").map(&:to_i) }
  .combination(2).reduce(0) do |a, ((x1, y1), (x2, y2))|
    area = ((x2 - x1).abs + 1) * ((y2 - y1).abs + 1)
    [area, a].max
  end

puts "Largest area: #{max_area}"
