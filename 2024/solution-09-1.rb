data = File.read('input-09.txt').chars[..-2].map(&:to_i)
total = 0
idx = 0
j = data.size - 1

data.each_with_index do |n, i|
  break if i > j

  if i.even?
    id = i / 2
    n.times do
      total += idx * id
      idx += 1
    end
  else
    id = j / 2
    n.times do
      id = (j -= 2) / 2 while data[j] < 1
      data[j] -= 1
      total += idx * id
      idx += 1
    end
  end
end

puts total
