def patterns(buttons)
  btn_len = buttons.first.length
  out = {}

  [0, 1].repeated_permutation(btn_len).each do |parity_pattern|
    out[parity_pattern] = {}
  end

  (0..buttons.length).each do |presses|
    (0...buttons.length).to_a.combination(presses) do |combo|
      pattern = Array.new(btn_len, 0)

      combo.each do |btn|
        buttons[btn].each_with_index { |v, i| pattern[i] += v }
      end

      parity_pattern = pattern.map { |i| i % 2 }

      unless out[parity_pattern].key?(pattern)
        out[parity_pattern][pattern] = presses
      end
    end
  end

  out
end


def presses_for(buttons, target_joltage)
  pattern_costs = patterns(buttons)
  cache = {}

  solve_single_aux = lambda do |g|
    return 0 if g.sum == 0
    return cache[g] if cache.key?(g)

    answer = Float::INFINITY
    parity = g.map { |i| i % 2 }

    pattern_costs[parity].each do |pattern, presses|
      ok = true
      pattern.each_with_index do |i, idx|
        if i > g[idx]
          ok = false
          break
        end
      end
      next unless ok

      new_goal = pattern.each_with_index.map do |i, idx|
        (g[idx] - i) / 2
      end

      answer = [
        answer,
        presses + 2 * solve_single_aux.call(new_goal)
      ].min
    end

    cache[g] = answer
  end

  solve_single_aux.call(target_joltage)
end

total = File.read("input-10.txt").split("\n").reduce(0) do |acc, line|
  ln = line.split(' ')

  target_joltage = ln.last[1..-2].split(',').map(&:to_i)

  buttons = ln[1..-2].map do |btn_str|
    btn_i = btn_str[1..-2].split(",").map(&:to_i)
    (0...target_joltage.length).map { |i| btn_i.include?(i) ? 1 : 0 }
  end

  acc + presses_for(buttons, target_joltage)
end

puts "Total presses: #{total}"
