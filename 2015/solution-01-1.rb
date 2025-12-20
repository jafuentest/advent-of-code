input = File.read("input-01.txt").strip
floor = input.chars.reduce(0) do |n, ch|
  n + ch == "(" ? 1 : -1
end

puts "Santa ends up in floor: #{floor}"
