string_literal_characters = 0
encoded_characters = 0
File.foreach('input.txt', chomp: true) do |line|
  string_literal_characters += line.length
  encoded_characters += line.dump.length
end

p encoded_characters - string_literal_characters
