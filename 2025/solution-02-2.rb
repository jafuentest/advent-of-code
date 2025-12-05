ranges = File.read("input-02.txt").split(",")
max_length = ranges.map { |e| e.split("-") }.flatten.max_by(&:length).length
max_length -= 1 if max_length.odd?
possible_invalid_ids = Set.new

1.upto(max_length / 2) do |digits|
  min = 10**(digits - 1)
  max = (10**digits) - 1
  invalid_ids = (min..max).to_a.map(&:to_s)

  d = digits
  repeats = 2
  loop do
    break if d * repeats > max_length

    invalid_ids.each do |id|
      possible_invalid_ids.add((id * repeats).to_i)
    end

    repeats += 1
  end
end

possible_invalid_ids = possible_invalid_ids.to_a.sort

total = 0
ranges.each do |range|
  a, b = range.split("-").map(&:to_i)
  i = possible_invalid_ids.bsearch_index { |e| e >= a }
  j = possible_invalid_ids.bsearch_index { |e| e >= b + 1 } - 1

  total += possible_invalid_ids[i..j].sum
end

puts "The total sum of all invalid IDs is: #{total}"
