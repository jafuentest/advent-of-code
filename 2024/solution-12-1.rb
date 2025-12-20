grid = File.read("input-12.txt")
  .split("\n")
  .map(&:chars)

len = grid.size
visited = Array.new(len) { Array.new(len, false) }

STEPS = [[-1, 0], [1, 0], [0, -1], [0, 1]].freeze

bfs = lambda do |i, j, char|
  queue = [[i, j]]
  visited[i][j] = true
  perimeter = 0
  area = 0

  until queue.empty?
    ci, cj = queue.shift
    area += 1

    STEPS.each do |di, dj|
      ni = ci + di
      nj = cj + dj

      if ni < 0 || nj < 0 || ni >= len || nj >= len || grid[ni][nj] != char
        perimeter += 1
      elsif !visited[ni][nj]
        visited[ni][nj] = true
        queue << [ni, nj]
      end
    end
  end

  area * perimeter
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
