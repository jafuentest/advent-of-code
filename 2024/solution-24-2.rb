GATE_AND = 0
GATE_OR = 1
GATE_XOR = 2
GATE_NOTE = 3 # Not a gate, contains some msg as tuple element 1

class ParsedData
  attr_accessor :wires, :gates

  def initialize
    @wires = {}
    @gates = []
  end
end

def parse_input(data)
  result = ParsedData.new
  lines = data.strip.split("\n")
  lines.each do |line|
    parts = line.split
    if parts.size == 2
      result.wires[parts[0][0..-2]] = parts[1].to_i
    elsif parts.size == 5
      gate_type = case parts[1]
                  when 'AND' then GATE_AND
                  when 'OR' then GATE_OR
                  when 'XOR' then GATE_XOR
      end
      gate = [
        parts[0],   # input1
        gate_type,  # gate_type
        parts[2],   # input2
        parts[4]    # output
      ]
      ch1 = gate[0][0]
      ch2 = gate[2][0]
      if (ch1 == 'y' && ch2 == 'x') || (ch2 == 'y' && ch1 != 'x') || (ch2 == 'x' && ch1 != 'y') ||
         (gate[0] < gate[2] && !'xy'.include?(ch1) && !'xy'.include?(ch2))
        gate = [gate[2], gate[1], gate[0], gate[3]] # Swap input1 and input2
      end
      result.gates << gate
    end
  end
  result
end

def gate_name(gate_type)
  case gate_type
  when GATE_AND then 'AND'
  when GATE_OR then 'OR'
  when GATE_XOR then 'XOR'
  end
end

def gate_map(gate)
  "#{gate[0]} #{gate_name(gate[1])} #{gate[2]} -> #{gate[3]}"
end

def find_switched_outputs(data)
  wrong_outputs = []
  x_bits = data.wires.keys.count { |w| w.start_with?('x') }

  prev_output_name_carry_out = '?'
  output_name_carry_out = '?'

  x_bits.times do |gate_index|
    group = []
    data.gates.each do |gate|
      x_gate = format('x%02d', gate_index)
      y_gate = format('y%02d', gate_index)
      next unless gate.include?(x_gate) || gate.include?(y_gate)

      group << gate
      next unless gate_index > 0

      data.gates.each do |gate2|
        next unless gate2.include?(gate[3]) && gate2 != gate

        gate2_new = gate2.dup
        if gate2_new[2] == gate[3]
          gate2_new = [gate2_new[2], gate2_new[1], gate2_new[0], gate2_new[3]]
        end

        group.delete(gate2)
        group << gate2_new unless group.include?(gate2_new)

        data.gates.each do |gate3|
          next unless (gate2[3] == gate3[0] || gate2[3] == gate3[2]) && gate2[1] == GATE_AND &&
                      gate2 != gate3 && gate3 != gate2_new && gate != gate3 &&
                      !group.include?([gate3[2], gate3[1], gate3[0], gate3[3]])

          group << gate3
        end
      end
    end

    extract_swap = lambda do |logic_group, name, gate_type, start_index, dest_index|
      index = logic_group[start_index..].find_index do |g|
        (name.empty? || g[0].start_with?(name) || g[2].start_with?(name)) && g[1] == gate_type
      end

      index += start_index
      logic_group[dest_index], logic_group[index] = logic_group[index], logic_group[dest_index]
    end

    extract_swap.call(group, 'x', GATE_XOR, 0, 0)
    extract_swap.call(group, 'x', GATE_AND, 0, 1)
    if gate_index > 0
      extract_swap.call(group, '', GATE_AND, 2, 2)
      extract_swap.call(group, '', GATE_OR, 2, 3)
      extract_swap.call(group, '', GATE_XOR, 2, 4)
    end

    if gate_index == 0
      correct_outputs = [format('z%02d', gate_index), group[1][3]]
      prev_output_name_carry_out = group[0][3]
    else
      outputs1_to3 = [group[1][3], group[2][3], group[3][3]]
      outputs1_to3.each do |test_out|
        wrong = false
        group.each do |gate|
          if test_out == gate[0] || test_out == gate[2]
            wrong = true
            break
          end
        end

        next if wrong

        output_name_carry_out = test_out
        outputs1_to3.delete(output_name_carry_out)
        break
      end

      correct_outputs = [
        group[2][0] == prev_output_name_carry_out ? group[2][2] : group[2][0],

        outputs1_to3[0], # Those two can be of any order actually
        outputs1_to3[1], # <-----/
        output_name_carry_out,
        format('z%02d', gate_index)
      ]
    end

    diff = []
    if gate_index == 0
      diff << [group[0][3], correct_outputs[0]] if group[0][3] != correct_outputs[0]
    else
      if group[4][3] != correct_outputs[4]
        diff << [group[4][3], correct_outputs[4]]
      elsif group[3][3] != correct_outputs[3]
        diff << [group[3][3], correct_outputs[3]]
      elsif group[0][3] != correct_outputs[0]
        diff << [group[0][3], correct_outputs[0]]
      else
        s1 = [group[1][3], group[2][3]].sort
        s2 = [correct_outputs[1], correct_outputs[2]].sort
        if s1 != s2
          diff << [s1[0], s2[0]]
          diff << [s1[1], s2[1]]
        end
      end
      wrong_outputs += diff
    end
  end
  wrong_outputs
end

data = parse_input(File.read('input-24.txt'))
switched_outputs = find_switched_outputs(data)
puts switched_outputs.flat_map(&:to_a).uniq.sort.join(',')
