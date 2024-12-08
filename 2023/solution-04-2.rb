lines = File.read('input-04.txt').split("\n")
owned_cards = (1..lines.size).to_h { |e| [e, 1] }

lines.each_with_index do |line, i|
  split_line = line.split('|')
  winning_numbers = split_line.first.scan(/\d+/)[1..]
  owned_numbers = split_line.last.scan(/\d+/)

  matched_numbers = winning_numbers & owned_numbers
  next unless matched_numbers.any?

  (i + 2..i + 1 + matched_numbers.size).each do |card_number|
    owned_cards[card_number] += owned_cards[i + 1]
  end
end

puts owned_cards.values.sum
