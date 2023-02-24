def index_at_column_x_row_1(x)
  x * (x + 1) / 2
end

def index_at_column_x_row_y(x, y)
  result = index_at_column_x_row_1(x)

  (x..(x + y - 2)).each do |i|
    result += i
  end

  result
end

index = index_at_column_x_row_y(3029, 2947)

code = 20151125
(index - 1).times do
  code = code * 252533 % 33554393
end

p code
