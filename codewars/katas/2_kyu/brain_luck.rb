# Description:

# Inspired from real-world Brainf**k, we want to create an interpreter of that language which will support the following instructions (the machine memory or 'data' should behave like a potentially infinite array of bytes, initialized to 0):

# > increment the data pointer (to point to the next cell to the right).
# < decrement the data pointer (to point to the next cell to the left).
# + increment (increase by one, truncate overflow: 255 + 1 = 0) the byte at the data pointer.
# - decrement (decrease by one, treat as unsigned byte: 0 - 1 = 255 ) the byte at the data pointer.
# . output the byte at the data pointer.
# , accept one byte of input, storing its value in the byte at the data pointer.
# [ if the byte at the data pointer is zero, then instead of moving the instruction pointer forward to the next command, jump it forward to the command after the matching ] command.
# ] if the byte at the data pointer is nonzero, then instead of moving the instruction pointer forward to the next command, jump it back to the command after the matching [ command.
# The function will take in input...

# the program code, a string with the sequence of machine instructions,
# the program input, a string, eventually empty, that will be interpreted as an array of bytes using each character's ASCII code and will be consumed by the , instruction
# ... and will return ...

# the output of the interpreted code (always as a string), produced by the . instruction.

# MY SOLUTION:
def brain_luck(code, input)
  cache, memory = [], []

  code.chars.each_with_index do |c, i|
    case c
    when '[' then memory.push(i)
    when ']' then j = memory.pop; cache[i], cache[j] = j, i
    end
  end

  input = input.chars.to_a
  result = ''

  m = Hash.new(0)
  p, i = 0, 0
  loop do
    break if i >= code.size

    case code[i]
    when '>' then p += 1
    when '<' then p -= 1
    when '+' then m[p] = (m[p] + 1) % 256
    when '-' then m[p] = (m[p] - 1) % 256
    when '.' then result << m[p].chr
    when ',' then m[p] = (input.shift || 0).ord
    when '[' then i = cache[i] if m[p].zero?
    when ']' then i = cache[i] unless m[p].zero?
    end

    i += 1
  end

  result
end
