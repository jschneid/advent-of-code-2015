def count_neighbors_on(grid, x, y)
  total = 0
  (y - 1..y + 1).each do |ny|
    (x - 1..x + 1).each do |nx|
      next if y == ny && x == nx
      next if ny < 0 || nx < 0 || ny >= grid.count || nx >= grid[0].count

      total += 1 if grid[ny][nx] == '#'
    end
  end
  total
end

def animate(grid)
  new_grid = Array.new(100) { Array.new(100) }
  (0..99).each do |y|
    (0..99).each do |x|
      neighbors_on = count_neighbors_on(grid, x, y)
      new_grid[y][x] = if grid[y][x] == '#'
                         [2, 3].include?(neighbors_on) ? '#' : '.'
                       else
                         neighbors_on == 3 ? '#' : '.'
                       end
    end
  end
  new_grid
end

grid = File.readlines('input.txt', chomp: true).map(&:chars)

100.times do
  grid = animate(grid)
end

p grid.join.count('#')
