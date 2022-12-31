def perform_instruction(line, lights, x, y)
  lights[y][x] = if line.start_with?("turn on")
                   lights[y][x] + 1
                 elsif line.start_with?("turn off")
                   [lights[y][x] - 1, 0].max
                 else # toggle
                   lights[y][x] + 2
                 end
end

lights = Array.new(1000) { Array.new(1000, 0) }

File.foreach('input.txt', chomp: true) do |line|
  tokenized_line = line.split

  x0, y0 = tokenized_line[-3].split(',').map(&:to_i)
  x1, y1 = tokenized_line[-1].split(',').map(&:to_i)

  (y0..y1).each do |y|
    (x0..x1).each do |x|
      perform_instruction(line, lights, x, y)
    end
  end
end

p lights.flatten.reduce(&:+)
