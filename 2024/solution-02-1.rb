def safe?(levels)
  ascending = levels[0] > levels[1]
  levels[1..].each_with_index do |level, i|
    diff = levels[i] - level

    return false if diff == 0 || diff.abs > 3 || (diff.positive? ^ ascending)
  end

  true
end

safe_count = 0

File.foreach("input-02.txt") do |line|
  safe_count += 1 if safe?(line.split.map(&:to_i))
end

puts safe_count
