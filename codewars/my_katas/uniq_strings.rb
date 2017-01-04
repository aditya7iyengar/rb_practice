# Given a string (CONTAINS ONLY LETTERS), string, you have to find out the number of unique strings (including string itself) that can be produced by re-arranging the letters of the string.

# Example:

# string = "ABC"

# uniqcount(string) = 6 #=> ["ABC", "ACB", "BAC", "BCA", "CAB", "CBA"]

# Notes: - Find the number of UNIQUE strings! - Strings are case insensitive.

# Examples:

# uniqcount("AB") = 2

# uniqcount("ABC") = 6

# uniqcount("ABA") = 3

# uniqcount("AbcD") = 24

# uniqcount("ABBb") = 4
#
# MY SOLUTION:


def uniq_count(string)
  char_repeats = {}
  string.downcase.scan(/\w/).each do |char|
    char_repeats[char] = char_repeats[char] ? char_repeats[char] + 1 : 1
  end
  
  total_fac = factorial(string.length)
  
  char_repeats.values.each do |value|
    total_fac /= factorial(value)
  end

  total_fac
end

private
def factorial(n)
  (1..n).reduce(1, :*)
end


puts uniq_count("ABC") == 6
puts uniq_count("ABA") == 3
puts uniq_count("Aba") == 3
puts uniq_count("ABcDEFgHIJ") == 3628800
puts uniq_count("ABcDEFgHIJbaslidbailsbdilasbdkanmsdklhkbHSJKHVDASH") == 34111429518116758488933545882757275627520000000
puts uniq_count("ABcDEFgHIJbaslidbailsbdilasbdkanmsdklhkbHSJKHVDASHVVYQVWKDVDWQUV") == 176478346352319876826993574633158714419916931040323433922560000000
