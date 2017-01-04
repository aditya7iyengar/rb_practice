# Lucas numbers are numbers in a sequence defined like this:

# L(n) = 2 if n = 0

# L(n) = 1 if n = 1

# otherwise

# L(n) = L(n - 1) + L(n - 2)
# Your mission is to define a function lucasnum(n) that returns the nth term of this sequence.

# Note: It should work for negative numbers as well (how you do this is you flip the equation around, so for negative numbers: L(n) = L(n + 2) - L(n + 1))

# MY INITIAL SOLUTION:
@cache = {}

def lucasnum(n)
  if @cache["#{n}"] 
      @cache["#{n}"]
  elsif n == 0
    2
  elsif n == 1
    1
  elsif n < 0
    @cache["#{n}"] = lucasnum(n + 2) - lucasnum(n + 1)
  else
    @cache["#{n}"] = lucasnum(n - 1) + lucasnum(n - 2)
  end
end

# MY FINAL SOLUTION:
def lucasnum(n)
  return 2 - n if n == 0 || n == 1
  
  a = 2; b = 1
  (0..n.abs - 2).each { x = a; a = b; b = x + b }
  
  return -b if n < 0 && n % 2 == 1
  b
end
