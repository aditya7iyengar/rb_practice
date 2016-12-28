# Description:

# Description:

# Remove all exclamation marks from sentence except at the end.

# Examples

# remove("Hi!") == "Hi!"
# remove("Hi!!!") == "Hi!!!"
# remove("!Hi") == "Hi"
# remove("!Hi!") == "Hi!"
# remove("Hi! Hi!") == "Hi Hi!"
# remove("Hi") == "Hi"
# Note

# Please don't post issue about difficulty or duplicate.

# MY SOLUTION:
def remove(s)
  s.gsub(/(?>!+)(?!$)/,'')
end
