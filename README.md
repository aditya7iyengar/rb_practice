# My Ruby Notes/Tricks

## String

### Modify and return a string:

- Use gsub(*args): Returns a copy of str with the all occurrences of pattern substituted for the second argument. The pattern is typically a Regexp; if given as a String, any regular expression metacharacters it contains will be interpreted literally, e.g. ‘\d’ will match a backlash followed by ‘d’, instead of a digit.

```.rb
"hello".gsub(/[aeiou]/, '*')                  #=> "h*ll*"
```

- The power of gsub(*args):

```.rb
garden.gsub(/(?!rock\b|gravel\b)\b(\w+)/, 'gravel') # Replaces every substring in garden which isn't gravel or rock with gravel.
```

## Lists

### List Comprehension:

- List.map { }:

```.rb
garden.split.map { |item| ["gravel", "rock"].include?(item) ? item : "gravel" }
```

### List to String:

- List.join(" "):

```.rb
garden.join(" ")
```

## Enum

### Reduce:

- Combines all elements of enum by applying a binary operation, specified by a block or a symbol that names a method or operator.

### Map:

- Enum.map(&:to_f)


### Examples:

```.rb
# Sum some numbers
(5..10).reduce(:+)                             #=> 45

# Same using a block and inject
(5..10).inject { |sum, n| sum + n }            #=> 45

# Multiply some numbers
(5..10).reduce(1, :*)                          #=> 151200

# Same using a block
(5..10).inject(1) { |product, n| product * n } #=> 151200

# find the longest word
longest = %w{ cat sheep bear }.inject do |memo, word|
  memo.length > word.length ? memo : word
end
longest                                        #=> "sheep"
```
