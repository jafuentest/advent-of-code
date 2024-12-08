file = File.open('input-06.txt')
times = file.readline.split(':').last.split.map(&:to_i)
distances = file.readline.split(':').last.split.map(&:to_i)
file.close

values = times.map.with_index do |race_time, i|
  count = 0

  race_time.times do |t|
    if ((race_time - t) * t) > distances[i]
      count += 1
    elsif count > 0
      break
    end
  end
  count
end

puts values.reduce(&:*)
