def powerset(items, &block)
  1.upto(items.size) do |size|
    items.combination(size).each(&block)
  end
end

containers = File.readlines('input.txt').map(&:to_i)

solutions = []
powerset(containers) do |containers_subset|
  solutions << containers_subset if containers_subset.sum == 150
end

solutions.sort_by!(&:length)
min_solution_length = solutions[0].length
p solutions.find_all { |solution| solution.length == min_solution_length }.length
