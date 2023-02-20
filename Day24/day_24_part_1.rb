starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)

packages = File.readlines('input.txt').map(&:to_i)
p packages

group_weight = packages.sum / 3

# packages.combination(3)

p "The target weight is #{group_weight}"

@target_weight_groups = []

# https://stackoverflow.com/a/4633515/12484
def subset_sum(numbers, target, partial = [])
  s = partial.inject 0, :+
  # check if the partial sum is equals to target

  # puts "sum(#{partial})=#{target}" if s == target
  @target_weight_groups << partial if s == target

  return if s >= target # if we reach the number why bother to continue

  (0..(numbers.length - 1)).each do |i|
    n = numbers[i]
    remaining = numbers.drop(i+1)
    subset_sum(remaining, target, partial + [n])
  end
end

def quantum_entanglement(packages_group)
  packages_group.reduce(&:*)
end

def minimum_quantum_entanglement(packages_groups)
  packages_groups.map { |group| quantum_entanglement(group) }.min
end

subset_sum(packages, group_weight)

p "Found #{@target_weight_groups.count} groups"

ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
p "elapsed: #{elapsed}"

@target_weight_groups.sort_by!(&:length)

p "The minimum first group length is #{@target_weight_groups[0].length}"
p "There are #{@target_weight_groups.select { |twg| twg.length == @target_weight_groups[0].length }.length} such groups"

first_group_potential_ideal_configurations = []

(0..@target_weight_groups.count - 3).each do |i|
  break if !first_group_potential_ideal_configurations.empty? && @target_weight_groups[i].length > first_group_potential_ideal_configurations[0].length

  p "Looking at first group #{@target_weight_groups[i]}..."

  (i + 1..@target_weight_groups.count - 2).each do |j|
    break if !first_group_potential_ideal_configurations.empty? && first_group_potential_ideal_configurations.last == @target_weight_groups[i]

    next unless(@target_weight_groups[i] & @target_weight_groups[j]).empty?

    (j + 1..@target_weight_groups.count - 1).each do |k|
      break if !first_group_potential_ideal_configurations.empty? && first_group_potential_ideal_configurations.last == @target_weight_groups[i]

      combined = @target_weight_groups[i] + @target_weight_groups[j] + @target_weight_groups[k]

      next unless combined.length == packages.length

      next unless (combined.detect.with_index { |e, idx| idx != combined.rindex(e) }).nil?

      p "Found a solution!: #{@target_weight_groups[i]} + #{@target_weight_groups[j]} + #{@target_weight_groups[k]}"

      first_group_potential_ideal_configurations << @target_weight_groups[i]

      if @target_weight_groups[i].length == @target_weight_groups[j].length
        first_group_potential_ideal_configurations << @target_weight_groups[j]
      end
    end
  end
end

p "Found #{first_group_potential_ideal_configurations} potential first group solutions"

ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
p "elapsed: #{elapsed}"

p minimum_quantum_entanglement(first_group_potential_ideal_configurations)
