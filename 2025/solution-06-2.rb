input = File.read("input-06.txt").split("\n")

nums = input[..-2].map(&:chars)
operands = input.last.chars

i = 0
res = 0
while i < nums.last.size
  operators = []
  operand = operands[i]
  loop do
    unless operands[i + 1] == " " || i == nums.last.size - 1
      i += 1
      break
    end

    operators << nums.map { |e| e[i] }.join.to_i
    i += 1
  end

  res += if operand == "+"
    operators.sum
  else
    operators.inject(:*)
  end
end

puts "Total sum: #{res}"
