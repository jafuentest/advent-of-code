def power(line)
  count = { 'red' => 0, 'green' => 0, 'blue' => 0 }
  game_info = line.split(': ')
  draws = game_info.last.split('; ')

  draws.each do |draw|
    draw.split(', ').each do |color_total|
      total, color = color_total.split
      total = total.to_i
      count[color] = total if total > count[color]
    end
  end

  count['red'] * count['green'] * count['blue']
end

puts File.read('input-02.txt')
  .split("\n")
  .reduce(0) { |total, e| total + power(e) }
