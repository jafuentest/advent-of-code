total = File.readlines("input-02.txt").reduce(0) do |area, line|
  l, w, h = line.split("x").map(&:to_i).sort
  area + (2 * (l + w)) + (l * w * h)
end

puts "Total wrapping paper needed: #{total}"
