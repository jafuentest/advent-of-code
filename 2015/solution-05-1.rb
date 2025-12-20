def pretty?(line)
  !line.match?(/ab|cd|pq|xy/) && line.match?(/([a-z])\1/) && line.count("aeiou") >= 3
end

total = File.readlines("input-05.txt").count do |line|
  pretty?(line.strip)
end

puts "Total nice strings: #{total}"
