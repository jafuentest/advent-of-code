def possible?(line)
  count = { 'red' => 0, 'green' => 0, 'blue' => 0 }
  game_info = line.split(': ')
  id = game_info.first.split.last.to_i
  draws = game_info.last.split('; ')

  draws.each do |draw|
    draw.split(', ').each do |color_total|
      total, color = color_total.split
      total = total.to_i
      count[color] = total if total > count[color]
    end
  end

  return id if count['red'] < 13 && count['green'] < 14 && count['blue'] < 15

  0
end

puts File.read('input-02.txt')
  .split("\n")
  .reduce(0) { |total, e| total + possible?(e) }
