string_literal_characters = 0
in_memory_characters = 0
File.foreach('input.txt', chomp: true) do |line|
  string_literal_characters += line.length
  in_memory_characters += line.undump.length
end

p string_literal_characters - in_memory_characters
