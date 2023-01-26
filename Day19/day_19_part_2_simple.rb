# Credit for this algorithm -- which doesn't even need to read the replacement
# rules for the input -- to u/CdiTheKing on Reddit (2015):
# https://www.reddit.com/r/adventofcode/comments/3xflz8/comment/cy4h7ji/
molecule = File.readlines('input.txt').last
total_atom_count = molecule.scan(/[A-Z]/).length
p total_atom_count - molecule.scan(/Rn/).length - molecule.scan(/Ar/).length - 2 * molecule.count('Y') - 1
