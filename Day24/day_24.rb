starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)

packages = File.readlines('input.txt').map(&:to_i)
p packages

groupings = []
i = 0
loop do
  group0 = []
  group1 = []
  group2 = []

  grouping_key = i.to_s(3).rjust(packages.length, '0')

  packages.each_with_index do |package, index|
    case grouping_key[index]
    when '0'
      group0 << package
    when '1'
      group1 << package
    when '2'
      group2 << package
    end
  end

  groupings << [group0, group1, group2]

  break if grouping_key == '2' * packages.length

  p "Generated #{i} groupings so far, key: #{grouping_key}, last: #{groupings.last}" if i % 1000000 == 0

  i += 1
end

ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)

p groupings

p "generated #{groupings.count} groupings"


elapsed = ending - starting
p "elapsed: #{elapsed}"

# todo sort and then uniq
