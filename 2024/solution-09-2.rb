data = File.read("input-09.txt").chars[..-2].map(&:to_i)

def map_drive(data)
  id = drive_idx = 0

  free_space = []
  files = []

  data.each_with_index do |n, i|
    if i.even?
      files << [drive_idx, n, id]
      id += 1
    else
      free_space << [drive_idx, n]
    end

    drive_idx += n
  end

  [free_space, files]
end

free_space, files = map_drive(data)

files.reverse_each.with_index do |(drive_idx, n, id), i|
  j = free_space.find_index do |space_idx, space_size|
    space_size >= n && space_idx < drive_idx
  end
  next if j.nil?

  space_idx, space_size = free_space[j]
  if space_size == n
    free_space.delete_at(j)
  else
    free_space[j] = [space_idx + n, space_size - n]
  end

  r = files.size - i - 1
  files[r] = [space_idx, n, id]
end

count = 0
files.each do |drive_idx, n, id|
  i = drive_idx
  n.times do
    count += id * i
    i += 1
  end
end

puts count
