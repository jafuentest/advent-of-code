data = {}
k = 0
File.foreach("input-05.txt") do |line|
  next if line == "\n"

  if line.start_with?("seeds")
    data[k] = line.split(": ").last.split.map(&:to_i)
  elsif line.include?(":")
    k += 1
    data[k] = []
  else
    data[k] << line.split.map(&:to_i)
  end
end

values = (0..(data[0].size - 1)).select(&:even?).map do |i|
  [data[0][i], data[0][i] + data[0][i + 1]]
end

(data.size - 1).times do |idx|
  map = data[idx + 1]
  next_map = []
  map.each do |dest_start, src_start, length|
    next_range = []
    values.each do |val_low, val_high|
      sorted_bounds = [val_low, val_high, src_start, src_start + length].sort
      sorted_bounds[1..].each_with_index do |high, i|
        low = sorted_bounds[i]
        next unless val_low <= low && low < high && high <= val_high

        if src_start <= low && low < high && high <= src_start + length
          next_map << [low - src_start + dest_start, high - src_start + dest_start]
        else
          next_range << [low, high]
        end
      end
    end
    values = next_range
  end
  values += next_map
end

puts values.map(&:first).min
