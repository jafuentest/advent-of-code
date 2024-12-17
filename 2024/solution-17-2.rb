lines = File.read('input-17.txt').lines

registers = lines[0, 3].map { |line| line.split(': ')[1].to_i }
PROGRAM = lines[4].split(': ')[1].split(',').map(&:to_i).freeze

def operand(code, registers)
  return code if code < 4

  return registers[0] if code == 4
  return registers[1] if code == 5

  registers[2]
end

def run_program(registers)
  out = []
  i = 0
  until i > PROGRAM.length - 2
    operand = PROGRAM[i + 1]

    case PROGRAM[i]
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

  out
end

pow = 0
a = 8**(PROGRAM.size - 1)
b = registers[1]
c = registers[2]

loop do
  out = run_program([a, b, c])
  break if out == PROGRAM

  pow = Math.log(a, 8).truncate

  out[1..].reverse_each.with_index do |n, i|
    break unless PROGRAM[PROGRAM.size - 1 - i] == n

    pow -= 1
  end

  a += 8**pow
end

puts a
