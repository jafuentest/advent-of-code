total = 0
rules_list, updates_list = File.read("input-05.txt")
  .split("\n\n")
  .map { |e| e.split("\n") }

rules = Hash.new { |h, k| h[k] = [] }
rules_list.each do |str|
  before, after = str.split("|").map(&:to_i)
  rules[after] << before
end

updates_list.each do |str|
  updates = str.split(",").map(&:to_i)
  valid = true

  updates.size.times do |i|
    break if i == updates.size

    num = nil
    while rules[updates[i]].any? { |e| updates[(i + 1)..].include?(num = e) }
      valid = false
      k = updates.find_index(num)
      updates.insert(i, updates.delete_at(k))
    end
  end

  total += updates[updates.size / 2] unless valid
end

puts total
