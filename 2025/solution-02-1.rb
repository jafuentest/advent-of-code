ranges = File.read("input-02.txt").split(",")

def dup?(num)
  digits = num.digits
  l = digits.length
  return false if l.odd?

  digits[0..((l / 2) - 1)] == digits[(l / 2)..]
end

sum = 0
ranges.each do |range|
  start_num, end_num = range.split("-").map(&:to_i)

  start_num.upto(end_num) do |num|
    sum += num if dup?(num)
  end
end

puts sum
