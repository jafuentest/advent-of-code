result = 0

File.foreach("input-12.txt") do |line|
  first, second = line.split
  prefix = first.chars
  suffix = second.split(",").map(&:to_i)

  pattern = []
  springs = []

  # Unfold the records
  4.times do
    pattern += prefix
    pattern << "?"
    springs += suffix
  end

  # Add trailing '.' so we don't check bounds for the last pattern.
  pattern += prefix
  pattern << "."
  springs += suffix

  # Calculate prefix sum of broken springs and unknowns before each index.
  sum = 0
  broken = [0]
  pattern.each_with_index do |b, i|
    sum += 1 if b != "."
    broken[i + 1] = sum
  end

  # Count combinations, handling first row as a special case.
  table = []
  first_size = springs[0]
  sum = 0
  valid = true
  wiggle = pattern.size - springs.sum - springs.size + 1
  wiggle.times do |i|
    if pattern[i + first_size] == "#"
      sum = 0
    elsif valid && broken[i + first_size] - broken[i] == first_size
      sum += 1
    end

    table[i + first_size] = sum
    valid &&= pattern[i] != "#"
  end

  # Count each subsequent spring.
  start = first_size + 1
  springs[1..].each_with_index do |size, row|
    previous = row * pattern.size
    current = (row + 1) * pattern.size
    sum = 0

    (start...(start + wiggle)).each do |i|
      if pattern[i + size] == "#"
        sum = 0
      elsif table[previous + i - 1] > 0 &&
            pattern[i - 1] != "#" &&
            broken[i + size] - broken[i] == size
        sum += table[previous + i - 1]
      end

      table[current + i + size] = sum
    end

    start += size + 1
  end

  result += sum
end

puts result
