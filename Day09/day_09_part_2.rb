def parse_input
  cities = []
  graph = {}

  File.foreach('input.txt', chomp: true) do |line|
    tokenized_line = line.split

    city0 = tokenized_line[0]
    city1 = tokenized_line[2]

    cities << city0 unless cities.include?(city0)
    cities << city1 unless cities.include?(city1)

    distance = tokenized_line[4].to_i
    graph[[city0, city1]] = distance
    graph[[city1, city0]] = distance
  end

  [cities, graph]
end

# Since there are only 8 cities, we can just use brute force.
# 8! is only about 40k permutations.
def brute_force_longest_traveling_salesman_without_return(cities, graph)
  best = 0
  cities.permutation do |visit_order|
    distance = 0
    (0..visit_order.length - 2).each do |index|
      distance += graph[[visit_order[index], visit_order[index + 1]]]
    end
    best = distance if distance > best
  end

  best
end

cities, graph = parse_input
p brute_force_longest_traveling_salesman_without_return(cities, graph)
