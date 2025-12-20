count = 0
valid_configs = %w[
  MMSS
  SMMS
  SSMM
  MSSM
]

words = File.read("input-04.txt")
  .split("\n")
  .map(&:chars)

(1..(words.size - 2)).each do |i|
  (1..(words.first.size - 2)).each do |j|
    next unless words[i][j] == "A"

    corners = [
      words[i - 1][j - 1],
      words[i - 1][j + 1],
      words[i + 1][j + 1],
      words[i + 1][j - 1]
    ].join

    count += 1 if valid_configs.include? corners
  end
end

puts count
