list = File.read('input-11.txt')
  .split
  .map(&:to_i)

25.times do
  new_list = []

  list.each do |n|
    if n == 0
      new_list << 1
    elsif (digits = n.digits).size.even?
      new_list += [digits[digits.size / 2..], digits[0..(digits.size / 2) - 1]]
        .map { |e| e.each_with_index.reduce(0) { |t, (n, i)| t + (n * (10**i)) } }
    else
      new_list << (2024 * n)
    end
  end
  list = new_list
end

puts list.size
