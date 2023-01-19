data = File.readlines('input.txt', chomp: true)
aunts = {}
data.each do |line|
  tokenized_line = line.split
  aunts[tokenized_line[1][0..-2]] = {
    tokenized_line[2][0..-2] => tokenized_line[3][0..-2].to_i,
    tokenized_line[4][0..-2] => tokenized_line[5][0..-2].to_i,
    tokenized_line[6][0..-2] => tokenized_line[7].to_i
  }
end

aunts.each do |id, values|
  next if values.key?('children') && values['children'] != 3
  next if values.key?('cats') && values['cats'] <= 7
  next if values.key?('samoyeds') && values['samoyeds'] != 2
  next if values.key?('pomeranians') && values['pomeranians'] >= 3
  next if values.key?('akitas') && values['akitas'] != 0
  next if values.key?('vizslas') && values['vizslas'] != 0
  next if values.key?('goldfish') && values['goldfish'] >= 5
  next if values.key?('trees') && values['trees'] <= 3
  next if values.key?('cars') && values['cars'] != 2
  next if values.key?('perfumes') && values['perfumes'] != 1

  p id
end
