def presses_for(target, buttons)
  (1..buttons.size).each do |presses|
    buttons.combination(presses).each do |combo|
      combo_sum = combo.reduce(0) { |sum, b| sum ^ b }
      return presses if combo_sum == target
    end
  end
end

total = File.read("input-10.txt").split("\n").reduce(0) do |acc, line|
  ln = line.split
  target_str = ln.first.chars[1..-2].map { |c| c == "#" ? 1 : 0 }.join
  target = target_str.to_i(2)

  buttons = ln[1..-2].map do |b|
    b[1..-2].split(",").reduce(0) do |str, c|
      str + (2**(target_str.size - 1 - c.to_i))
    end
  end

  acc + presses_for(target, buttons)
end

puts "Total presses: #{total}"
