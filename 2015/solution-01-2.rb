input = File.read("input-01.txt").strip
floor = 0

input.chars.each_with_index do |c, i|
  floor += c == "(" ? 1 : -1
  next if floor >= 0

  puts "Santa first enters the basement at position: #{i + 1}"
  break
end
