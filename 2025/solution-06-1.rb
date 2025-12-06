input = File.read("input-06.txt").split("\n")

nums = input[..-2].map { |e| e.split.map(&:to_i) }
operands = input.last.split

res = operands.each_with_index.reduce(0) do |sum, (operand, i)|
  operators = nums.map { |e| e[i] }
  if operand == "+"
    sum + operators.sum
  else
    sum + operators.inject(:*)
  end
end

puts "Total sum: #{res}"
