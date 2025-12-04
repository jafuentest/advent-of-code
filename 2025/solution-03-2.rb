total = 0

File.foreach("input-03.txt") do |line|
  digits = 12
  idx = 0
  sub_total = 0

  nums = line.chomp.chars.map(&:to_i)
  loop do
    break if digits == 0

    sub_array = nums[idx..-digits]

    max = sub_array.max
    idx += sub_array.index(max) + 1
    power = 10 ** (digits - 1)
    digits -= 1

    sub_total += max * power
  end
  total += sub_total
end

puts "The total output joltage is now #{total}"
