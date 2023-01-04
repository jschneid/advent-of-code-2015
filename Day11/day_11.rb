def contains_straight(password)
  (0..password.length - 3).each do |index|
    return true if [
      password[index].next.next,
      password[index + 1].next,
      password[index + 2]
    ].uniq.length == 1
  end
  false
end

def contains_only_legal_characters(password)
  illegal_characters = ['i', 'o', 'l']
  illegal_characters.none? { |illegal_character| password.include?(illegal_character) }
end

def contains_two_pairs_of_double_letters(password)
  password.chars
          .slice_when(&:!=)
          .map(&:length)
          .select { |length| length >= 2 }
          .sum >= 4
end

def meets_requirements(password)
  contains_only_legal_characters(password) &&
    contains_straight(password) &&
    contains_two_pairs_of_double_letters(password)
end

def next_valid_password(password)
  loop do
    password = password.next
    break if meets_requirements(password)
  end
  password
end

password = 'redacted'
p password = next_valid_password(password)
p password = next_valid_password(password)
