hands = {}
File.foreach('input-07.txt') do |line|
  hand, bid = line.split
  hands[hand] = bid.to_i
end

ORDER = %w[J 2 3 4 5 6 7 8 9 T Q K A].freeze
def compare_cards(a, b)
  ORDER.find_index(a) - ORDER.find_index(b)
end

def compare_tallys(hand_a, hand_b)
  same_kind_a = (hand_a.except('J').values.max || 0) + hand_a.fetch('J', 0)
  same_kind_b = (hand_b.except('J').values.max || 0) + hand_b.fetch('J', 0)

  return same_kind_a - same_kind_b unless same_kind_a == same_kind_b
  return 0 if same_kind_a == 1

  next_a = hand_a.values.sort.last(2).min
  next_b = hand_b.values.sort.last(2).min
  return next_a - next_b if [2, 3].include?(same_kind_a)

  0
end

def compare_hands(a, b)
  kinds = compare_tallys(a.chars.tally, b.chars.tally)
  return kinds unless kinds == 0

  a.chars.each_with_index do |card_a, i|
    card_b = b[i]
    return compare_cards(card_a, card_b) unless card_a == card_b
  end
end

total = 0

hands.keys.sort { |a, b| compare_hands(a, b) }.each_with_index do |hand, i|
  total += (i + 1) * hands[hand]
end

puts total
