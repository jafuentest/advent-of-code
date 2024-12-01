list1 = []
list2 = Hash.new(0)

File.foreach('input-01.txt') do |line|
  list_items = line.split
  list1 << list_items.first.to_i
  list2[list_items.last.to_i] += 1
end

puts list1.map { |i| i * list2[i] }.sum
