def nice_string(line)
  return false if ['ab', 'cd', 'pq', 'xy'].any? { |word| line.include?(word) }

  return false if line.chars.each_with_index.find { |c, i| i > 0 && c == line[i - 1] }.nil?

  return false if (line.chars - ['a', 'e', 'i', 'o', 'u']).length > line.length - 3

  true
end

p File.readlines('input.txt').select { |line| nice_string(line) }.count

