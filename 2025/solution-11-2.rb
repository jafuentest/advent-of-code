$map = {}
$paths_counts = {}

File.read("input-11.txt")
  .split("\n")
  .each do |line|
    from, to = line.split(": ")
    $map[from] = to.split
  end

def paths_counts(key, dac: false, fft: false)
  cache_key = [key, dac, fft].join
  return $paths_counts[cache_key] if $paths_counts.key?(cache_key)

  dac ||= key == "dac"
  fft ||= key == "fft"

  if $map[key].include?("out")
    return $paths_counts[cache_key] = dac && fft ? 1 : 0
  end

  $paths_counts[cache_key] = $map[key].sum do |k|
    paths_counts(k, dac:, fft:)
  end
end

puts "Total paths: #{paths_counts('svr')}"
