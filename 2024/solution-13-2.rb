TOLERANCE = 1e-3
def integer?(number)
  (number - number.round).abs < TOLERANCE
end

games = File.read('input-13.txt').split("\n\n")

costs = games.map do |game|
  btn_a, btn_b, target = game.split("\n")
    .map { |e| e.scan(/\d+/).map(&:to_f) }

  ax, ay = btn_a
  bx, by = btn_b
  x, y = target.map { |e| e + 10_000_000_000_000 }

  a = (x - (y * bx / by)) / (ax - (ay * bx / by))
  b = (y - (a * ay)) / by

  integer?(a) && integer?(b) ? (a * 3) + b : 0
end

puts costs.sum
