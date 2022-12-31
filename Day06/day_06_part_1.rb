def perform_instruction(line, lights, x, y)
  lights[y][x] = if line.start_with?("turn off")
                   false
                 elsif line.start_with?("turn on")
                   true
                 else # toggle
                   !lights[y][x]
                 end
end

lights = Array.new(1000) { Array.new(1000, false) }

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

p lights.flatten.count(true)
