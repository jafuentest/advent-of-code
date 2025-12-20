lights = Array.new(1000) { Array.new(1000, false) }

File.readlines("input-06.txt").each do |line|
  line_arr = line.split
  line_arr.shift if line_arr[0] == "turn"
  action, start_coords, _, end_coords = line_arr
  x1, y1 = start_coords.split(",").map(&:to_i)
  x2, y2 = end_coords.split(",").map(&:to_i)

  (x1..x2).each do |x|
    (y1..y2).each do |y|
      case action
      when "toggle"
        lights[x][y] = !lights[x][y]
      when "on"
        lights[x][y] = true
      when "off"
        lights[x][y] = false
      end
    end
  end
end

puts "Number of lights on: #{lights.flatten.count(true)}"
