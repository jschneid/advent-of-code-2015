def read_packages
  File.readlines('input.txt').map(&:to_i)
end

# https://stackoverflow.com/a/4633515/12484
def subset_sum(numbers, target, partial = [])
  sum = partial.sum

  @target_weight_groups << partial if sum == target

  return if sum >= target

  (0..(numbers.length - 1)).each do |i|
    n = numbers[i]
    remaining = numbers.drop(i + 1)
    subset_sum(remaining, target, partial + [n])
  end
end

def quantum_entanglement(packages_group)
  packages_group.reduce(&:*)
end

def minimum_quantum_entanglement(packages_groups)
  packages_groups.map { |group| quantum_entanglement(group) }.min
end

def get_first_group_potential_ideal_configurations(packages)
  @target_weight_groups.sort_by!(&:length)

  first_group_potential_ideal_configurations = []

  (0..@target_weight_groups.count - 3).each do |i|
    break if !first_group_potential_ideal_configurations.empty? && @target_weight_groups[i].length > first_group_potential_ideal_configurations[0].length

    (i + 1..@target_weight_groups.count - 2).each do |j|
      break if !first_group_potential_ideal_configurations.empty? && first_group_potential_ideal_configurations.last == @target_weight_groups[i]

      next unless (@target_weight_groups[i] & @target_weight_groups[j]).empty?

      (j + 1..@target_weight_groups.count - 1).each do |k|
        break if !first_group_potential_ideal_configurations.empty? && first_group_potential_ideal_configurations.last == @target_weight_groups[i]

        combined = @target_weight_groups[i] + @target_weight_groups[j] + @target_weight_groups[k]

        next unless combined.length == packages.length

        next unless (combined.detect.with_index { |e, idx| idx != combined.rindex(e) }).nil?

        first_group_potential_ideal_configurations << @target_weight_groups[i]

        if @target_weight_groups[i].length == @target_weight_groups[j].length
          first_group_potential_ideal_configurations << @target_weight_groups[j]
        end
      end
    end
  end

  first_group_potential_ideal_configurations
end

packages = read_packages

target_weight = packages.sum / 3

# Populate @target_weight_groups with all subsets of packages
# whose total weight is the target weight.
@target_weight_groups = []
subset_sum(packages, target_weight)

first_group_potential_ideal_configurations = get_first_group_potential_ideal_configurations(packages)

p minimum_quantum_entanglement(first_group_potential_ideal_configurations)
