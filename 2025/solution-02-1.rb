ranges = File.read("input-02.txt").split(",")
ids = []

def dup?(num)
  digits = num.to_s.chars
  return false if digits.length.odd?

  first_half = digits[0..((digits.length / 2) - 1)]
  second_half = digits[(digits.length / 2)..]
  first_half == second_half
end

ranges.each do |range|
  start_str, end_str = range.split("-")
  start_num = start_str.to_i
  end_num = end_str.to_i

  start_num.upto(end_num) do |num|
    ids << num if dup?(num)
  end
end

puts ids.sum
