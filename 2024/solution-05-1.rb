total = 0
rules_list, updates_list = File.read('input-05.txt')
  .split("\n\n")
  .map { |e| e.split("\n") }

rules = Hash.new { |h, k| h[k] = [] }
rules_list.each do |str|
  before, after = str.split('|').map(&:to_i)
  rules[after] << before
end

updates_list.each do |str|
  updates = str.split(',').map(&:to_i)
  valid = true

  updates.each_with_index do |page, i|
    break if i == updates.size - 1

    if rules[page].any? { |e| updates[i + 1..].include?(e) }
      valid = false
      break
    end
  end

  total += updates[updates.size / 2] if valid
end

puts total
