total = File.readlines("input-02.txt").reduce(0) do |area, line|
  l, w, h = line.split("x").map(&:to_i).sort
  area + (3 * l * w) + (2 * w * h) + (2 * h * l)
end

puts "Total wrapping paper needed: #{total}"
