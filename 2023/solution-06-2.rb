race_time, distance = File.read("input-06.txt").lines
  .map { |e| e.split(":").last.split.inject(:+).to_i }

root = Math.sqrt((race_time**2) - (4 * distance))
min_time = ((race_time - root) / 2).ceil
max_time = ((race_time + root) / 2).ceil

puts max_time - min_time
