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

def all_possible_replacement_results_for(molecule, source_atom, replacement_atom)
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

  results
end

def all_possible_replacement_results(molecule, reverse_replacements)
  possible_replacements = []

  source_atoms = reverse_replacements.keys
  source_atoms.each do |source_atom|
    replacement_atoms = reverse_replacements[source_atom]
    replacement_atoms.each do |replacement_atom|
      possible_replacements.concat all_possible_replacement_results_for(molecule, source_atom, replacement_atom)
    end
  end

  possible_replacements.uniq
end

def fabricate(molecule, reverse_replacements)
  visited_molecules = Set.new
  possible_replacements = all_possible_replacement_results(molecule, reverse_replacements)

  unvisited_states = []
  possible_replacements.each do |possible_replacement|
    unvisited_states << { molecule: possible_replacement, steps: 1 }
  end

  i = 0

  loop do
    unvisited_states.sort_by! { |unvisited_state| unvisited_state[:molecule].length }

    state = unvisited_states.shift
    visited_molecules.add(state[:molecule])

    if state[:molecule] == 'e'
      return state[:steps]
    end

    i += 1
    if (i % 10000 == 0)
      p "#{Time.now.strftime("%H:%M")} #{i} molecules evaluated, #{unvisited_states.length} enqueued, shortest: #{unvisited_states.first[:molecule].length}"
    end
    p "#{Time.now.strftime("%H:%M")} #{state[:molecule]} (#{state[:steps]})" if state[:molecule].length <= 20

    possible_replacements = all_possible_replacement_results(state[:molecule], reverse_replacements)

    if possible_replacements.empty?
      p "Dead end: #{state[:molecule]} (length: #{state[:molecule].length}) (steps: #{state[:steps]})"
    end

    possible_replacements.each do |possible_replacement|
      unvisited_states << { molecule: possible_replacement, steps: state[:steps] + 1 } unless visited_molecules.include?(possible_replacement)
    end
  end

  -1
end

reverse_replacements, medicine_molecule = read_reverse_replacements

p fabricate(medicine_molecule, reverse_replacements)
p "done @ #{Time.now.strftime("%H:%M")}"
