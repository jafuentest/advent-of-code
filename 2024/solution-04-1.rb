count = 0
words = File.read("input-04.txt")
  .split("\n")
  .map(&:chars)

words.size.times do |i|
  words.first.size.times do |j|
    [-1, 0, 1].each do |y|
      next if (y == -1 && i < 3) || (y == 1 && i > words.size - 4)

      [-1, 0, 1].each do |x|
        next if (x == -1 && j < 3) || (x == 1 && j > words.first.size - 4)

        a = words[i][j]
        b = words[i + y][j + x]
        c = words[i + (y * 2)][j + (x * 2)]
        d = words[i + (y * 3)][j + (x * 3)]

        count += 1 if a == "X" && b == "M" && c == "A" && d == "S"
      end
    end
  end
end

puts count
