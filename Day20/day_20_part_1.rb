# https://stackoverflow.com/a/72449326/12484
def divisors_of(n)
  (1..Math.sqrt(n)).each_with_object([]) { |i, arr| (n % i).zero? && arr << i && n / i != i && arr << n / i }
end

house_number = 0
loop do
  house_number += 1
  presents_delivered = divisors_of(house_number).reduce(&:+) * 10
  if presents_delivered >= 29000000
    p house_number
    break
  end
end
