list1 = []
list2 = []
diff = []

File.foreach("input-01.txt") do |line|
  list_items = line.split
  list1 << list_items.first.to_i
  list2 << list_items.last.to_i
end

list1.sort!
list2.sort!

list1.each_with_index do |item1, i|
  diff << (item1 - list2[i]).abs
end

puts diff.sum
