grid = File.read('input-12.txt')
  .split("\n")
  .map(&:chars)

len = grid.size
visited = Array.new(len) { Array.new(len, false) }

STEPS = [[-1, 0], [1, 0], [0, -1], [0, 1]].freeze

bfs = lambda do |i0, j0, char|
  queue = [[i0, j0]]
  visited[i0][j0] = true
  area = 0
  perimeters = {}

  until queue.empty?
    i, j = queue.shift
    area += 1

    STEPS.each do |di, dj|
      ni = i + di
      nj = j + dj

      if ni < 0 || nj < 0 || ni >= len || nj >= len || grid[ni][nj] != char
        perimeters[[di, dj]] = Set.new unless perimeters.key?([di, dj])
        perimeters[[di, dj]].add([i, j])
      elsif !visited[ni][nj]
        visited[ni][nj] = true
        queue << [ni, nj]
      end
    end
  end

  sides = 0
  perimeters.each_value do |v|
    seen_perimeters = Set.new
    v.each do |pi, pj|
      next if seen_perimeters.include?([pi, pj])

      sides += 1
      queue = [[pi, pj]]
      until queue.empty?
        i, j = queue.shift
        next if seen_perimeters.include? [i, j]

        seen_perimeters.add [i, j]
        STEPS.each do |di, dj|
          ni = i + di
          nj = j + dj
          queue.append([ni, nj]) if v.include?([ni, nj])
        end
      end
    end
  end

  area * sides
end

sum = 0
(0...len).each do |i|
  (0...len).each do |j|
    next if visited[i][j]

    char = grid[i][j]
    sum += bfs.call(i, j, char)
  end
end

puts sum
