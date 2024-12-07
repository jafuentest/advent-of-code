def valid?(operands, target, i = 1, total = operands.first, operation = :*)
  return false if i == operands.size

  result = total.send(operation, operands[i])
  return true if result == target && i == operands.size - 1

  if operation == :*
    found = valid?(operands, target, i, total, :+)
    return found if found
  end

  valid?(operands, target, i + 1, result)
end

total = 0
File.foreach('input-07.txt') do |line|
  target_str, operands_str = line.split(': ')
  target = target_str.to_i

  total += target if valid?(operands_str.split.map(&:to_i), target)
end

puts total
