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

def get_minimum_quantum_entanglement(packages)
  # Sort by length, then by the array itself, so that we evaluate the
  # "passenger compartment" (smallest length) group items in order of
  # values ascending, such that the first potential solution we find,
  # it is THE minimum "quantum entanglement" solution.
  @target_weight_groups.sort_by! { |group| [group.length, group] }

  first_group_potential_ideal_configurations = []

  (0..@target_weight_groups.count - 4).each do |i|
    (i + 1..@target_weight_groups.count - 3).each do |j|
      next unless (@target_weight_groups[i] & @target_weight_groups[j]).empty?

      (j + 1..@target_weight_groups.count - 2).each do |k|
        combined = @target_weight_groups[i] + @target_weight_groups[j] + @target_weight_groups[k]
        next unless (combined.detect.with_index { |e, idx| idx != combined.rindex(e) }).nil?

        (k + 1..@target_weight_groups.count - 1).each do |l|
          combined = @target_weight_groups[i] + @target_weight_groups[j] + @target_weight_groups[k] + @target_weight_groups[l]
          next unless (combined.detect.with_index { |e, idx| idx != combined.rindex(e) }).nil?
          next unless combined.length == packages.length

          return quantum_entanglement(@target_weight_groups[i])
        end
      end
    end
  end

  first_group_potential_ideal_configurations
end

packages = read_packages

target_weight = packages.sum / 4

# Populate @target_weight_groups with all subsets of packages
# whose total weight is the target weight.
@target_weight_groups = []
subset_sum(packages, target_weight)

p get_minimum_quantum_entanglement(packages)
