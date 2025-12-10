ranges = File.read("input-02.txt").split(",")

def dup?(num)
  digits = num.to_s.chars
  return false if digits.length.odd?

  first_half = digits[0..((digits.length / 2) - 1)]
  second_half = digits[(digits.length / 2)..]
  first_half == second_half
end

sum = 0
ranges.each do |range|
  start_num, end_num = range.split("-").map(&:to_i)

  start_num.upto(end_num) do |num|
    sum += num if dup?(num)
  end
end

puts sum
