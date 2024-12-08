file = File.open('input-06.txt')
race_time = file.readline.split(':').last.split.reduce(&:+).to_i
distance = file.readline.split(':').last.split.reduce(&:+).to_i
file.close

count = 0
race_time.times do |t|
  if ((race_time - t) * t) > distance
    count += 1
  elsif count > 0
    break
  end
end

puts count
