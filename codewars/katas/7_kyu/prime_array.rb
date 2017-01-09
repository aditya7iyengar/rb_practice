def prime_array(n)
  (2..n).select { |num| is_prime?(num) }
end

private

def is_prime?(n)
  return true if [2, 3].include?(n)
  start_lim = n / 2
  (2..start_lim).inject([true, start_lim]) do |val, num|
    if !val.first
      [false, val[1]]
    elsif num > val[1]
      val
    else
      is_prime = n % num != 0
      lim = is_prime ? n / (num + 1) : num
      [is_prime, lim]
    end
  end.first
end

# def is_prime?(n)
#   (2..Math.sqrt(n)).none? {|f| n % f == 0}
# end

puts is_prime?(2)
puts is_prime?(3)
puts is_prime?(4)
puts is_prime?(5)
puts is_prime?(6)
puts is_prime?(7)
puts is_prime?(8)
puts is_prime?(9)
puts is_prime?(10)
puts is_prime?(11)
puts is_prime?(2017)
puts prime_array(11)
