def contains_duplicate_two_letter_pair(line)
  (0..line.length - 3).each do |i|
    substring = line[i..i + 1]
    return true if line[i + 2..].include?(substring)
  end

  false
end

def contains_repeating_semi_adjacent_letters(line)
  (1..line.length - 1).each do |i|
    return true if line[i - 1] == line[i + 1]
  end

  false
end

def nice_string(line)
  contains_duplicate_two_letter_pair(line) && contains_repeating_semi_adjacent_letters(line)
end

p File.readlines('input.txt').select { |line| nice_string(line) }.count
