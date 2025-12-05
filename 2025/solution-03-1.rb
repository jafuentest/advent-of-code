total = 0

File.foreach("input-03.txt") do |line|
  nums = line.chomp.chars.map(&:to_i)
  max = nums[..-2].max
  idx = nums.index(max) + 1
  second_max = nums[idx..].max

  total += (max * 10) + second_max
end

puts "The total output joltage is: #{total}"
