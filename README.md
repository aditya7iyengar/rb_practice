# My Ruby Notes/Tricks

## String

### Modify and return a string:

- Use gsub(*args): Returns a copy of str with the all occurrences of pattern substituted for the second argument. The pattern is typically a Regexp; if given as a String, any regular expression metacharacters it contains will be interpreted literally, e.g. ‘\d’ will match a backlash followed by ‘d’, instead of a digit.

```.rb
"hello".gsub(/[aeiou]/, '*')                  #=> "h*ll*"
```


