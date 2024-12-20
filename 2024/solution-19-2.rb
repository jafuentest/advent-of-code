input = File.read('input-19.txt').split("\n\n")
patterns = input[0].split(', ')
targets = input[1].split("\n")

def count_combinations(patterns, target)
  relevant_patterns = patterns.select { |e| target.include?(e) }
  dp = Array.new(target.length + 1, 0)
  dp[0] = 1

  (1..target.length).each do |i|
    relevant_patterns.each do |pattern|
      if i >= pattern.length && target[i - pattern.length...i] == pattern
        dp[i] += dp[i - pattern.length]
      end
    end
  end

  dp[target.length]
end

puts targets.reduce(0) { |t, e| t + count_combinations(patterns, e) }
