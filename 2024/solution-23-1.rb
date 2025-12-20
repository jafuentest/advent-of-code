PC_ID_MAP = ("aa".."zz").map.with_index { |c, i| [c, i] }.to_h
POSSIBLE_IDS = PC_ID_MAP.select { |pc, _id| pc.start_with?("t") }.values.to_set

pcs = Set.new
n = PC_ID_MAP.size
adj_matrix = Array.new(n) { Array.new(n, false) }

File.foreach("input-23.txt", chomp: true) do |line|
  pc1, pc2 = line.split("-").map { |pc| PC_ID_MAP[pc] }
  pcs.merge([pc1, pc2])
  adj_matrix[pc1][pc2] = true
  adj_matrix[pc2][pc1] = true
end

triangles = []
(0...n).each do |i|
  next unless pcs.include?(i)

  ((i + 1)...n).each do |j|
    next unless pcs.include?(j)

    ((j + 1)...n).each do |k|
      next unless adj_matrix[i][j] && adj_matrix[j][k] && adj_matrix[k][i] && [i, j, k].any? do |id|
        POSSIBLE_IDS.include?(id)
      end

      triangles << [i, j, k]
    end
  end
end

puts triangles.size
