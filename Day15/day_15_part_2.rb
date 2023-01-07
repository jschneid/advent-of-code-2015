def process_input
  ingredients = []
  File.foreach('input.txt', chomp: true) do |line|
    tokenized_line = line.split.map(&:to_i)
    ingredients << {
      capacity: tokenized_line[2],
      durability: tokenized_line[4],
      flavor: tokenized_line[6],
      texture: tokenized_line[8],
      calories: tokenized_line[10]
    }
  end
  ingredients
end

def best_score_cookie(ingredients)
  best_score = 0
  (0..100).each do |a|
    (0..(100 - a)).each do |b|
      (0..(100 - a - b)).each do |c|
        d = 100 - a - b - c
        capacity = a * ingredients[0][:capacity] + b * ingredients[1][:capacity] + c * ingredients[2][:capacity] + d * ingredients[3][:capacity]
        durability = a * ingredients[0][:durability] + b * ingredients[1][:durability] + c * ingredients[2][:durability] + d * ingredients[3][:durability]
        flavor = a * ingredients[0][:flavor] + b * ingredients[1][:flavor] + c * ingredients[2][:flavor] + d * ingredients[3][:flavor]
        texture = a * ingredients[0][:texture] + b * ingredients[1][:texture] + c * ingredients[2][:texture] + d * ingredients[3][:texture]
        calories = a * ingredients[0][:calories] + b * ingredients[1][:calories] + c * ingredients[2][:calories] + d * ingredients[3][:calories]

        next unless calories == 500

        score = [capacity, 0].max * [durability, 0].max * [flavor, 0].max * [texture, 0].max
        best_score = [best_score, score].max
      end
    end
  end
  best_score
end

ingredients = process_input
puts best_score_cookie(ingredients)
