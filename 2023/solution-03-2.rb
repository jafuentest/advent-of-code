require "English"

valid_numbers = []
lines = File.read("input-03.txt").split("\n")

lines.each_with_index do |line, i|
  next if i == 0 || i == lines.size - 1

  line.scan(%r{[*@\-+#%=/$&]}) do |symbol_match|
    gear_numbers = []
    _symbol = symbol_match
    j = $LAST_MATCH_INFO.offset(0)[0]

    # same line numbers
    line.scan(/\d+/) do |number_match|
      number = number_match
      k = $LAST_MATCH_INFO.offset(0)[0]
      s_start = k - 1
      s_end = number.size + k
      gear_numbers << number if [s_start, s_end].include?(j)
    end

    # upper line numbers
    lines[i - 1].scan(/\d+/) do |number_match|
      number = number_match
      k = $LAST_MATCH_INFO.offset(0)[0]
      s_start = k - 1
      s_end = number.size + k
      gear_numbers << number if (s_start..s_end).include?(j)
    end

    # upper line numbers
    lines[i + 1].scan(/\d+/) do |number_match|
      number = number_match
      k = $LAST_MATCH_INFO.offset(0)[0]
      s_start = k - 1
      s_end = number.size + k
      gear_numbers << number if (s_start..s_end).include?(j)
    end

    valid_numbers.push gear_numbers.map(&:to_i).inject(:*) if gear_numbers.size > 1
  end
end

puts valid_numbers.sum
