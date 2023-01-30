require 'set'

# https://stackoverflow.com/a/72449326/12484
def divisors_of(n)
  (1..Math.sqrt(n)).each_with_object([]) { |i, arr| (n % i).zero? && arr << i && n / i != i && arr << n / i }
end

active_elves = {} # ID: houses visited
retired_elves = Set.new

house_number = 0
loop do
  house_number += 1

  active_elves[house_number] = 0

  elves_visiting_house = divisors_of(house_number)
  active_elves_visiting_house = []
  elves_visiting_house.each do |elf|
    active_elves_visiting_house << elf unless retired_elves.include?(elf)
  end

  presents_delivered = active_elves_visiting_house.reduce(&:+) * 11

  if presents_delivered >= 29000000
    p house_number
    break
  end

  active_elves_visiting_house.each do |elf|
    houses_visited = active_elves[elf]
    if houses_visited == 49
      active_elves.delete(elf)
      retired_elves.add(elf)
    else
      active_elves[elf] += 1
    end
  end
end
