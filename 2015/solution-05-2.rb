def pretty?(line)
  repeats_pair = false
  has_sandwiched_letter = false
  pairs = {}

  (0..(line.length - 2)).each do |i|
    unless repeats_pair
      pair = line[i] + line[i + 1]
      repeats_pair = true if pairs[pair]&.any? { |index| index < i - 1 }

      pairs[pair] ||= []
      pairs[pair] << i
    end

    next if i == 0

    has_sandwiched_letter = true if line[i - 1] == line[i + 1]
    return true if repeats_pair && has_sandwiched_letter
  end

  false
end

total = File.readlines("input-05.txt").count do |line|
  pretty?(line.strip)
end

puts "Total nice strings: #{total}"
