list = File.read('input-11.txt').split.map(&:to_i)
$cache = Hash.new { |h, k| h[k] = [] }

def split(digits)
  mid = digits.size / 2
  left = digits[mid..]
  right = digits[0...mid]

  [left, right].map do |part|
    part.each_with_index.reduce(0) { |sum, (n, i)| sum + (n * (10**i)) }
  end
end

def process(n, t)
  return $cache[n][t] if $cache.dig(n, t)

  val = if n == 0
    t == 1 ? 1 : process(1, t - 1)
  elsif (digits = n.digits).size.even?
    t == 1 ? 2 : split(digits).map { |e| process(e, t - 1) }.sum
  else
    t == 1 ? 1 : process(2024 * n, t - 1)
  end

  $cache[n][t] = val
end

puts list.map { |n| process(n, 75) }.sum
