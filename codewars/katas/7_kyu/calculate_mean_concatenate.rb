# Description:

# You will be given an array which will include both integers and characters.

# Return an array of length 2 with a[0] representing the mean of the ten integers as a floating point number. There will always be 10 integers and 10 characters. Create a single string with the characters and return it as a[1] while maintaining the original order.

# lst = ['u', '6', 'd', '1', 'i', 'w', '6', 's', 't', '4', 'a', '6', 'g', '1', '2', 'w', '8', 'o', '2', '0']
# Here is an example of your return

# [3.6, "udiwstagwo"]

# MY SOLUTION:
def mean(lst)
  int_num = 0; int_sum = 0; str = ""

  lst.each { |char| char =~ /\d/ ? (int_sum += char.to_i; int_num += 1) : str << char }

  mean = int_num == 0 ? 0 : 1.0 * int_sum / int_num

  [mean, str]
end

# BEST SOLUTION:
def mean(lst)
  [lst.map(&:to_f).reduce(:+)/10, lst.grep(/[^\d]/).join]
end
