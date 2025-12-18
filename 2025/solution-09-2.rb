def build_rect(a, c)
  [
    a,
    [a[0], c[1]],
    c,
    [c[0], a[1]]
  ]
end

def point_on_segment?(pp, p1, p2)
  pp[0].between?(p1[0], p2[0]) && pp[1].between?(p1[1], p2[1])
end

def point_in_polygon?(p_x, p_y, poly)
  inside = false
  edge = poly.size - 1

  (0...poly.size).each do |i|
    a = poly[i]
    b = poly[i == edge ? 0 : i + 1]
    a_x, a_y = a
    b_x, b_y = b

    return true if (a_y == b_y) && (p_y == a_y) && point_on_segment?([p_x, p_y], a, b)

    next if a_y == b_y

    if (p_y > [a_y, b_y].min) && (p_y <= [a_y, b_y].max)
      xinters = a_x + ((p_y - a_y) * (b_x - a_x) / (b_y - a_y))
      inside = !inside if xinters >= p_x
    end
  end

  inside
end

def segments_cross?(x1, y1, x2, y2, x3, y3, x4, y4)
  # first segment horizontal, second vertical
  if y1 == y2 && x3 == x4
    return x3 > [x1, x2].min && x3 < [x1, x2].max && y1 > [y3, y4].min && y1 < [y3, y4].max
  end

  # first vertical, second horizontal
  if x1 == x2 && y3 == y4
    return y3 > [y1, y2].min && y3 < [y1, y2].max && x1 > [x3, x4].min && x1 < [x3, x4].max
  end

  false
end

def square_inside_polygon?(a, c, polygon, poly_edges)
  rect = build_rect(a, c)
  rect.each { |x, y| return false unless point_in_polygon?(x, y, polygon) }

  rect_edges = [
    [rect[0], rect[1]],
    [rect[1], rect[2]],
    [rect[2], rect[3]],
    [rect[3], rect[0]]
  ]

  rect_edges.each do |(sx1, sy1), (sx2, sy2)|
    poly_edges.each do |(px1, py1), (px2, py2)|
      return false if segments_cross?(sx1, sy1, sx2, sy2, px1, py1, px2, py2)
    end
  end

  true
end

polygon = File.read("input-09.txt")
  .split("\n")
  .map { |line| line.split(",").map(&:to_i) }

max_area = 0
edge = polygon.size - 1
poly_edges = polygon.map.with_index { |pp, i| [pp, polygon[i == edge ? 0 : i + 1]] }

polygon.combination(2).each do |(x1, y1), (x2, y2)|
  area = ((x2 - x1).abs + 1) * ((y2 - y1).abs + 1)
  next if area <= max_area || !square_inside_polygon?([x1, y1], [x2, y2], polygon, poly_edges)

  max_area = area
end

puts "Largest area inside the polygon: #{max_area}"
