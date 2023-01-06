def process_input
  reindeers = []
  File.foreach('input.txt') do |line|
    tokenized_line = line.split
    reindeers << {
      fly_speed: tokenized_line[3].to_i,
      fly_duration: tokenized_line[6].to_i,
      rest_duration: tokenized_line[13].to_i,
      flying: true,
      duration_left: tokenized_line[6].to_i,
      distance_flown: 0,
      points: 0
    }
  end
  reindeers
end

def simulate_next_second_for(reindeer)
  if reindeer[:duration_left].zero?
    if reindeer[:flying]
      reindeer[:flying] = false
      reindeer[:duration_left] = reindeer[:rest_duration]
    else
      reindeer[:flying] = true
      reindeer[:duration_left] = reindeer[:fly_duration]
    end
  end

  reindeer[:distance_flown] += reindeer[:fly_speed] if reindeer[:flying]
  reindeer[:duration_left] -= 1
end

def award_points(reindeers)
  leading_distance = reindeers.map { |reindeer| reindeer[:distance_flown] }.max
  reindeers.each { |reindeer| reindeer[:points] += 1 if reindeer[:distance_flown] == leading_distance }
end

def simulate_next_second(reindeers)
  reindeers.each { |reindeer| simulate_next_second_for(reindeer) }
  award_points(reindeers)
end

reindeers = process_input
2503.times { simulate_next_second(reindeers) }
p reindeers.map { |reindeer| reindeer[:points] }.max
