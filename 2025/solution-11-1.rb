$map = {}
$paths = []

File.read("input-11.txt")
  .split("\n")
  .each do |line|
    from, to = line.split(": ")
    $map[from] = to.split
  end

def traverse(key, tail = [])
  if $map[key].include?("out")
    $paths << (tail + [key, "out"])
  else
    next_keys = $map[key].reject { |k| tail.include?(k) }
    next_keys.each { |k| traverse(k, tail + [key]) }
  end
end

traverse("you")

puts "Total paths: #{$paths.size}"
