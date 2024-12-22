REPEAT = 25

KEYPAD1 = [
  ['7', '8', '9'],
  ['4', '5', '6'],
  ['1', '2', '3'],
  ['', '0', 'A']
].freeze

KEYPAD2 = [
  ['', '^', 'A'],
  ['<', 'v', '>']
].freeze

def map_movements(keypad, num_keypad)
  movements_map = {}
  ei = num_keypad ? keypad.length - 1 : 0
  ej = 0

  keypad.each_with_index do |row, i|
    row.each_with_index do |b1, j|
      next if b1 == ''

      keypad.each_with_index do |row2, ti|
        row2.each_with_index do |b2, tj|
          next if b2 == ''

          v_mov = ti - i
          h_mov = tj - j

          v_str = (v_mov > 0 ? 'v' : '^') * v_mov.abs
          h_str = (h_mov > 0 ? '>' : '<') * h_mov.abs

          arr_str = h_mov < 0 ? [h_str, v_str] : [v_str, h_str]
          movements_map["#{b1}#{b2}"] = if (j == ej || tj == ej) && (i == ei || ti == ei)
            "#{arr_str.reverse.join}A"
          else
            "#{arr_str.join}A"
          end
        end
      end
    end
  end

  movements_map
end

def num_keypad_robot_movement(code, robot)
  moves_with_count = {}

  (0..code.length - 2).each do |i|
    movement = code[i] + code[i + 1]
    instruction = robot[movement]
    move = "A#{instruction[0]}"

    moves_with_count[move] ||= 0
    moves_with_count[move] += 1

    (0..instruction.length - 2).each do |j|
      move = instruction[j] + instruction[j + 1]
      moves_with_count[move] ||= 0
      moves_with_count[move] += 1
    end
  end
  moves_with_count
end

def dir_keypad_robot_movement(moves_with_count, robot)
  new_moves_with_count = {}

  moves_with_count.each do |movement, count|
    instruction = robot[movement[0] + movement[1]]
    move = "A#{instruction[0]}"

    new_moves_with_count[move] ||= 0
    new_moves_with_count[move] += count

    (0..instruction.length - 2).each do |i|
      move = instruction[i] + instruction[i + 1]
      new_moves_with_count[move] ||= 0
      new_moves_with_count[move] += count
    end
  end
  new_moves_with_count
end

nums_robot = map_movements(KEYPAD1, true)
dirs_robot = map_movements(KEYPAD2, false)

total = File.read('input-21.txt').split("\n").reduce(0) do |t, code|
  num = code.gsub('A', '').to_i
  moves_with_count = num_keypad_robot_movement("A#{code}", nums_robot)

  REPEAT.times do
    moves_with_count = dir_keypad_robot_movement(moves_with_count, dirs_robot)
  end

  t + (num * moves_with_count.values.sum)
end

puts total
