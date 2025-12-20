def safe?(levels)
  ascending = levels[0] > levels[1]
  levels[1..].each_with_index do |level, i|
    diff = levels[i] - level

    return false if diff == 0 || diff.abs > 3 || (diff.positive? ^ ascending)
  end

  true
end

def soft_safe?(levels)
  return true if safe?(levels)

  (0...levels.size).any? do |i|
    modified_array = levels.dup
    modified_array.delete_at(i)
    safe?(modified_array)
  end
end

safe_count = 0

File.foreach("input-02.txt") do |line|
  levels = line.split.map(&:to_i)
  safe_count += 1 if soft_safe?(levels)
end

puts safe_count
