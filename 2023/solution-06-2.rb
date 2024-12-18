race_time, distance = File.read('input-06.txt').lines
  .map { |e| e.split(':').last.split.inject(:+).to_i }

count = 0
race_time.times do |t|
  if ((race_time - t) * t) > distance
    count += 1
  elsif count > 0
    break
  end
end

puts count
