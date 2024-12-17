lines = File.read('input-17.txt').lines

registers = lines[0, 3].map { |line| line.split(': ')[1].to_i }
program = lines[4].split(': ')[1].split(',').map(&:to_i)

def operand(code, registers)
  return code if code < 4

  return registers[0] if code == 4
  return registers[1] if code == 5

  registers[2]
end

out = []
i = 0
until i > program.length - 2
  operand = program[i + 1]

  case program[i]
  when 0
    registers[0] = registers[0] / (2**operand(operand, registers))
  when 1
    registers[1] = registers[1] ^ operand
  when 2
    registers[1] = operand(operand, registers) % 8
  when 3
    if registers[0] > 0
      i = operand
      next
    end
  when 4
    registers[1] = registers[1] ^ registers[2]
  when 5
    out << (operand(operand, registers) % 8)
  when 6
    registers[1] = registers[0] / (2**operand(operand, registers))
  when 7
    registers[2] = registers[0] / (2**operand(operand, registers))
  end

  i += 2
end

puts out.join(',')
