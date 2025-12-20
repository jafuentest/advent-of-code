require "English"

def symbol?(str)
  str.match?(/[^\d|.]/)
end

valid_numbers = []
lines = File.read("input-03.txt").split("\n")

lines.each_with_index do |line, i|
  line.scan(/\d+/) do |number_match|
    number = number_match
    j = $LAST_MATCH_INFO.offset(0)[0]

    s_start = [j - 1, 0].max
    s_end = number.size + (j.zero? ? 1 : 2)

    if (i > 0 && symbol?(lines[i - 1][s_start, s_end])) ||
       (i < lines.size - 1 && symbol?(lines[i + 1][s_start, s_end])) ||
       (j > 0 && symbol?(line[j - 1])) ||
       (j + number.size < line.size - 1 && symbol?(line[j + number.size]))

      valid_numbers.push(number.to_i)
    end
  end
end

puts valid_numbers.sum
