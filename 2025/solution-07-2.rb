lines = File.read("input-07.txt").split("\n").map(&:chars)

def value_for(coord, current_value)
  if coord.is_a?(Integer)
    current_value + coord
  else
    current_value
  end
end

lines[1][lines.first.index("S")] = 1
i = 2

while i < lines.length
  line = lines[i]
  line.each_with_index do |char, j|
    val = lines[i - 1][j]

    if char == "."
      lines[i][j] = lines[i + 1][j] = value_for(lines[i + 1][j], val) if val.is_a?(Integer)
      next
    end

    if char == "^" && val.is_a?(Integer)
      lines[i + 1][j - 1] = value_for(lines[i + 1][j - 1], val)
      lines[i + 1][j + 1] = value_for(lines[i + 1][j + 1], val)
    end
  end
  i += 1
end

puts "Total sum: #{lines.last.map(&:to_i).sum}"
