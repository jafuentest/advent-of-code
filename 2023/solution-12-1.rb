$variants = {}

def find_variants(str)
  return $variants[str] if $variants.key?(str)

  return $variants[str] = [str] unless str.include? "?"

  variants = find_variants(str.sub("?", ".")) + find_variants(str.sub("?", "#"))
  $variants[str] = variants
end

total = File.read("input-12.txt").lines.reduce(0) do |t, line|
  string, numbers = line.split
  numbers = numbers.split(",").map(&:to_i)

  t + find_variants(string).count do |variant|
    numbers == variant.split(".").reject(&:empty?).map(&:size)
  end
end

puts total
