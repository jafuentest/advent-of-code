lines = File.read("input-07.txt").split("\n")

i = 2
c=0
lines[1][lines.first.index("S")] = "|"
while i < lines.length do
  line = lines[i]
  line.each_char.with_index do |char, j|
    if char == "."
      lines[i][j] = lines[i+1][j] = "|" if lines[i-1][j] == "|"
      next
    end

    if char == "^" && lines[i-1][j] == "|"
      lines[i+1][j-1] = lines[i+1][j+1] = "|"
      c+=1
    end
  end
  i += 1
end

puts lines.join("\n")
puts "Total sum: #{lines.sum { |line| line.count("|") }}"
puts "Total sum: #{c}"
