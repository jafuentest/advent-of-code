map = { "0,0" => 1 }
i = j = 0

File.read("input-03.txt").chars.each do |c|
  case c
  when ">"
    i += 1
  when "<"
    i -= 1
  when "^"
    j += 1
  when "v"
    j -= 1
  end

  map["#{i},#{j}"] ||= 1
end

puts map.size
