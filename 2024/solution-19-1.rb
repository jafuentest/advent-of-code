input = File.read('input-19.txt').split("\n\n")
patterns = input[0].split(', ')
targets = input[1].split("\n")

def can_form_target?(patterns, target)
  relevant_patterns = patterns.select { |e| target.include?(e) }
  checks = Array.new(target.length + 1, false)
  checks[0] = true

  (1..target.length).each do |i|
    relevant_patterns.each do |pattern|
      if i >= pattern.length && target[i - pattern.length...i] == pattern
        checks[i] = checks[i] || checks[i - pattern.length]
      end
    end
  end

  checks[target.length]
end

puts targets.reduce(0) { |t, e| t + can_form_target?(patterns, e) ? 1 : 0 }
