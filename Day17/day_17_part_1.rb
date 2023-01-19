def powerset(items, &block)
  1.upto(items.size) do |size|
    items.combination(size).each(&block)
  end
end

containers = File.readlines('input.txt').map(&:to_i)

solutions = 0
powerset(containers) do |containers_subset|
  solutions += 1 if containers_subset.sum == 150
end

p solutions
