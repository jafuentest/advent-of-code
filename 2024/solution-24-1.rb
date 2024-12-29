inputs = File.read('input-24.txt').split("\n\n")
$wires = {}
$gates = {}
solved_wires = Set.new

inputs[0].split("\n").each do |line|
  wire, value = line.split(': ')
  $wires[wire] = value.to_i
  solved_wires << wire
end

inputs[1].split("\n").each do |line|
  operation, target = line.split(' -> ')
  $gates[target] = operation.split
end

def solve_wires(gate1, gate2)
  if $wires[gate1].nil?
    g1, operator, g2 = $gates[gate1]
    $wires[gate1] = operate(operator, g1, g2)
  end

  if $wires[gate2].nil?
    g1, operator, g2 = $gates[gate2]
    $wires[gate2] = operate(operator, g1, g2)
  end

  [$wires[gate1], $wires[gate2]]
end

def operate(op, gate1, gate2)
  a, b = solve_wires(gate1, gate2)

  case op
  when 'AND'
    a & b
  when 'OR'
    a | b
  when 'XOR'
    a ^ b
  end
end

$gates.each do |k, v|
  g1, operator, g2 = v
  $wires[k] = operate(operator, g1, g2)
end

z_wires = $wires.filter { |k, _v| k.start_with?('z') }
binary = z_wires.keys.sort.map { |k| z_wires[k] }
puts binary.map.with_index { |n, i| n * (2**i) }.sum
