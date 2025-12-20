require "digest"
input = File.read("input-04.txt").strip

digest = ""
i = 0

until digest.start_with?("00000")
  i += 1
  digest = Digest::MD5.hexdigest("#{input}#{i}")
end

puts "Part 1: #{i}"

until digest.start_with?("000000")
  i += 1
  digest = Digest::MD5.hexdigest("#{input}#{i}")
end

puts "Part 2: #{i}"
