def look_and_say(input)
  input.chars.slice_when(&:!=).map { |chunk| "#{chunk.length}#{chunk.first}" }.join
end

puzzle_input = '1113222113'

result = puzzle_input
40.times do
  result = look_and_say(result)
end

p result.length
