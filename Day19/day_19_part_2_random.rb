require 'set'

def read_reverse_replacements
  data = File.readlines('input.txt', chomp: true)
  medicine_molecule = data.pop

  reverse_replacements = {}
  data.pop
  data.each do |line|
    tokenized_line = line.split
    (reverse_replacements[tokenized_line[2]] ||= []) << tokenized_line[0]
  end

  [reverse_replacements, medicine_molecule]
end

@memoized_atom_replacement_results = {}

def all_possible_replacement_results(molecule, source_atom, replacement_atom)
  if @memoized_atom_replacement_results.key?([molecule, source_atom, replacement_atom])
    return @memoized_atom_replacement_results[[molecule, source_atom, replacement_atom]]
  end

  results = []

  (0..molecule.length - source_atom.length).each do |i|
    if molecule[i..i + source_atom.length - 1] == source_atom
      result = ''
      result += molecule[0..i - 1] if i > 0
      result += replacement_atom
      result += molecule[i + source_atom.length..] if i + source_atom.length < molecule.length - 1
      results << result
    end
  end

  @memoized_atom_replacement_results[[molecule, source_atom, replacement_atom]] = results

  results
end

@memoized_replacement_results = {}

def random_replacement_result(molecule, reverse_replacements)
  possible_replacements = []

  if @memoized_replacement_results.key?(molecule)
    possible_replacements = @memoized_replacement_results[molecule]
  else
    source_atoms = reverse_replacements.keys
    source_atoms.each do |source_atom|
      replacement_atoms = reverse_replacements[source_atom]
      replacement_atoms.each do |replacement_atom|
        possible_replacements.concat all_possible_replacement_results(molecule, source_atom, replacement_atom)
      end
    end
  end

  possible_replacements -= @dead_ends.to_a
  @memoized_replacement_results[molecule] = possible_replacements

  return molecule if possible_replacements.empty?

  possible_replacements_with_Rn = possible_replacements.select { |m| !m.include?('Rn') }
  return possible_replacements_with_Rn.sample unless possible_replacements_with_Rn.empty?

  possible_replacements.sample
end

@dead_ends = Set.new

def fabricate(molecule, reverse_replacements)
  steps = 0
  original_molecule = molecule
  last_molecule = molecule
  while molecule != 'e'
    molecule = random_replacement_result(molecule, reverse_replacements)
    steps += 1
    if molecule == last_molecule || molecule == nil
      p "Dead end: #{molecule} after #{steps} steps"
      @dead_ends.add(molecule)
      steps = 0
      molecule = original_molecule
    else
      last_molecule = molecule
    end
  end
  steps
end

reverse_replacements, medicine_molecule = read_reverse_replacements
reverse_replacements = reverse_replacements.sort_by { |k, v| k.length }.reverse.to_h

p fabricate(medicine_molecule, reverse_replacements)
