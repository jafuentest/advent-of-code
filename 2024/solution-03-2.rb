regex = /
  mul\((\d+),\s*(\d+)\) | # Matches mul(X, Y) with numbers
  (do\(\)) |
  (don't\(\))
/x

instructions = File.read("input-03.txt")
  .scan(regex)
  .map do |mul_x, mul_y, do_match, dont_match|
    if mul_x && mul_y
      { type: "mul", n: mul_x.to_i * mul_y.to_i }
    elsif do_match
      { type: "do" }
    elsif dont_match
      { type: "don't" }
    end
  end

flag = true
total = 0

instructions.each do |instruction|
  total += instruction[:n] if flag && instruction[:type] == "mul"
  flag = true if instruction[:type] == "do"
  flag = false if instruction[:type] == "don't"
end

puts total
