def happiness_in_configuration(attendee_ordering, happiness_gains)
  pairings = attendee_ordering.each_cons(2).to_a << [attendee_ordering.first, attendee_ordering.last]
  pairings.reduce(0) { |sum, pairing| sum + happiness_gains[pairing] + happiness_gains[pairing.reverse] }
end

def process_input
  attendees = []
  happiness_gains = {}

  File.foreach('input.txt', chomp: true) do |line|
    tokenized_line = line.split
    person0 = tokenized_line[0]
    person1 = tokenized_line[10][..-2]
    happiness_change = tokenized_line[3].to_i
    happiness_change *= -1 if tokenized_line[2] == 'lose'

    attendees << person0 unless attendees.include?(person0)
    attendees << person1 unless attendees.include?(person1)

    happiness_gains[[person0, person1]] = happiness_change
  end

  [attendees, happiness_gains]
end

def add_myself(attendees, happiness_gains)
  attendees.each do |attendee|
    happiness_gains[[attendee, 'Jon']] = 0
    happiness_gains[['Jon', attendee]] = 0
  end

  attendees << 'Jon'

  [attendees, happiness_gains]
end

attendees, happiness_gains = process_input
attendees, happiness_gains = add_myself(attendees, happiness_gains)

optimal_happiness = attendees.permutation.reduce(-1.0 / 0.0) do |max_happiness, ordering|
  happiness = happiness_in_configuration(ordering, happiness_gains)
  happiness > max_happiness ? happiness : max_happiness
end

p optimal_happiness
