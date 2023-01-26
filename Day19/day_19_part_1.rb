data = File.readlines('input.txt', chomp: true)
starting_molecule = data.pop

replacements = {}
data.pop
data.each do |line|
  tokenized_line = line.split
  (replacements[tokenized_line[0]] ||= []) << tokenized_line[2]
end

def all_possible_replacement_results(molecule, source_atom, replacement_atom)
  results = []

  (0..molecule.length - 1).each do |i|
    if molecule[i..i + source_atom.length - 1] == source_atom
      result = ''
      result += molecule[..i - 1] if i > 0
      result += replacement_atom
      result += molecule[i + source_atom.length..] if i + source_atom.length < molecule.length - 1
      results << result
    end
  end

  results
end

results = []
replacements.each do |source_atom, replacement_atoms|
  replacement_atoms.each do |replacement_atom|
    results.concat all_possible_replacement_results(starting_molecule, source_atom, replacement_atom)
  end
end

p results.uniq.length
