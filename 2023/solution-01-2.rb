# The reason one is o1e is because:
# The right calibration values for string "eighthree" is 83 and for "sevenine" is 79.
NUMBERS_IN_LETTERS = {
  "one" => "o1e",
  "two" => "t2o",
  "three" => "t3e",
  "four" => "f4r",
  "five" => "f5e",
  "six" => "s6x",
  "seven" => "s7n",
  "eight" => "e8t",
  "nine" => "n9e"
}.freeze

def line_to_number(line)
  numbers = line
    .gsub(/#{NUMBERS_IN_LETTERS.keys.join('|')}/, NUMBERS_IN_LETTERS)
    .gsub(/#{NUMBERS_IN_LETTERS.keys.join('|')}/, NUMBERS_IN_LETTERS)
    .chars.select { |e| e.to_i.to_s == e }

  (numbers.first + numbers.last).to_i
end

puts File.read("input-01.txt")
  .split("\n")
  .map { |e| line_to_number(e) }
  .reduce(0) { |total, e| total + e }
