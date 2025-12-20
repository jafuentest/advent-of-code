map = { "0,0" => 1 }
si = sj = bi = bj = 0

def move(i, j, c)
  case c
  when ">"
    [i + 1, j]
  when "<"
    [i - 1, j]
  when "^"
    [i, j + 1]
  when "v"
    [i, j - 1]
  end
end

File.read("input-03.txt").strip.chars.each_slice(2) do |cs, cj|
  si, sj = move(si, sj, cs)
  bi, bj = move(bi, bj, cj)
  map["#{si},#{sj}"] ||= 1
  map["#{bi},#{bj}"] ||= 1
end

puts map.size
