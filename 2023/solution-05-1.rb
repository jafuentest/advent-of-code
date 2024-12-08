class RangeMapping
  def initialize
    @ranges = []
  end

  def add_range(dest_start, source_start, length)
    @ranges << { source_start: source_start, dest_start: dest_start, length: length }
  end

  def [](key)
    @ranges.each do |range|
      if key.between?(range[:source_start], range[:source_start] + range[:length] - 1)
        return range[:dest_start] + (key - range[:source_start])
      end
    end
    key
  end
end

data = {}
current_key = nil
File.foreach('input-05.txt') do |line|
  next if line == "\n"

  if line.start_with?('seeds')
    current_key = :seeds
    data[current_key] = line.split(': ').last.split.map(&:to_i)
  elsif line.include?(':')
    current_key = line.split.first.gsub('-', '_').to_sym
    data[current_key] = RangeMapping.new
  else
    data[current_key].add_range(*line.split.map(&:to_i))
  end
end

min = Float::INFINITY
data[:seeds].each do |seed|
  soil = data[:seed_to_soil][seed]
  fertilizer = data[:soil_to_fertilizer][soil]
  water = data[:fertilizer_to_water][fertilizer]
  light = data[:water_to_light][water]
  temperature = data[:light_to_temperature][light]
  humidity = data[:temperature_to_humidity][temperature]
  location = data[:humidity_to_location][humidity]

  min = location if location < min
end

puts min
