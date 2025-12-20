def valid?(operands, target, i = 1, total = operands.first, operation = :*)
  return false if i == operands.size

  result = if operation == :c
    (total.to_s + operands[i].to_s).to_i
  else
    total.send(operation, operands[i])
  end

  return true if result == target && i == operands.size - 1

  unless operation == :c
    found = valid?(operands, target, i, total, operation == :* ? :+ : :c)
    return found if found
  end

  valid?(operands, target, i + 1, result)
end

total = 0
File.foreach("input-07.txt") do |line|
  target_str, operands_str = line.split(": ")
  target = target_str.to_i

  total += target if valid?(operands_str.split.map(&:to_i), target)
end

puts total
