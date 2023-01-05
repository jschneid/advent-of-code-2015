require 'json'

def sum_excluding_objects_with_a_red_value(node)
  return 0 if node.is_a?(Hash) && node.values.include?('red')

  return node if node.is_a? Integer
  return 0 if node.is_a? String

  node = node.values if node.is_a?(Hash)

  node.reduce(0) { |sum, child| sum + sum_excluding_objects_with_a_red_value(child) }
end

json = JSON.parse(File.read('input.txt'))
p sum_excluding_objects_with_a_red_value(json)
