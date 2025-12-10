areas = File.read("input-09.txt")
  .split("\n")
  .map { |line| line.split(",").map(&:to_i) }
  .combination(2).map do |(x1, y1), (x2, y2)|
    ((x2 - x1).abs + 1) * ((y2 - y1).abs + 1)
  end

puts "Largest area: #{areas.max}"
