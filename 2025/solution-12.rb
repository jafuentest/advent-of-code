result = File.read("input-12.txt").split("\n\n").last.split("\n").reduce(0) do |count, line|
  area_str, box_counts = line.split(": ")
  total_boxes = box_counts.split.map(&:to_i).sum

  w, h = area_str.split("x").map(&:to_i)
  max_boxes = (h / 3) * (w / 3)

  count + (total_boxes <= max_boxes ? 1 : 0)
end

puts "Total boxes that fit: #{result}"
