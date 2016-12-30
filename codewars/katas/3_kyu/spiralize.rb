def spiralize(size)
  spiral = (1..size).map { |num| Array.new(size, 0) }

  num = 1
  (size/3 + 1).times do
    row = (num - 1) * (-1) ** (num - 1)
    (num - 2..size - num).each { |col| spiral[row][col] = 1 }
    (num..size - num).each { |row| spiral[row][size-num] = 1 }

    num += 1
    row = (num - 1) * (-1) ** (num - 1)
    (num - 2..size - num).each { |col| spiral[row][col] = 1 }
    (num..size - num).each { |row| spiral[row][num-2] = 1 }

    num += 1
  end

  spiral[size / 2][size / 2 - 1] = 0 unless size.odd?
  spiral
end
