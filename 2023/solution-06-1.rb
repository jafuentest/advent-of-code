times, distances = File.read('input-06.txt').lines
  .map { |e| e.split(':').last.split.map(&:to_i) }

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
