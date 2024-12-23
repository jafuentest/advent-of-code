PC_ID_MAP = ('aa'..'zz').map.with_index { |c, i| [c, i] }.to_h
POSSIBLE_IDS = PC_ID_MAP.select { |pc, _id| pc.start_with?('t') }.values.to_set

def neighbors(node, adj_matrix)
  adj_matrix[node].each_index.select { |i| adj_matrix[node][i] }
end

def bron_kerbosch(r, pp, x, adj_matrix, largest_clique)
  if pp.empty? && x.empty?
    largest_clique.replace(r) if r.size > largest_clique.size
    return
  end

  pp.each do |node|
    new_r = r + [node]
    new_p = pp & neighbors(node, adj_matrix)
    new_x = x & neighbors(node, adj_matrix)
    bron_kerbosch(new_r, new_p, new_x, adj_matrix, largest_clique)
    pp.delete(node)
    x << node
  end
end

pcs = Set.new
n = PC_ID_MAP.size
adj_matrix = Array.new(n) { Array.new(n, false) }

File.foreach('input-23.txt', chomp: true) do |line|
  pc1, pc2 = line.split('-').map { |pc| PC_ID_MAP[pc] }
  pcs.merge([pc1, pc2])
  adj_matrix[pc1][pc2] = true
  adj_matrix[pc2][pc1] = true
end

pp = (0...n).to_a
r = []
x = []
largest_clique = []

bron_kerbosch(r, pp, x, adj_matrix, largest_clique)

puts largest_clique.sort.map { |pc| PC_ID_MAP.key(pc) }.join(',')
