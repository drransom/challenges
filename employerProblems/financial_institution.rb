# Parsing an API response
#
# Suppose you are calling a JSON API that responds to requests using a nested
# Hash, where the values are either other Hashes, or Strings, with no other
# possible options.
#
# Given a sequence of keys, write a method that traverses the Hash to return
# the String stored at the terminal key in the sequence.
# assumes the keys exist
def parse(hash, keys)
  value = hash[keys[0]]
  value.is_a?(Hash) ? parse(hash[keys[0]], keys[1..-1]) : value
end

input = {
  k1: "v1",
  k2: {
    k21: "v21",
    k22: {
      k221: "v221"
    }
  },
  k3: {
    k31: "v31"
  }
}


if (output = parse(input, [:k2, :k22, :k221]) == "v221")
  puts "Success!"
else
  puts "Output #{output.inspect} did not match 'v221'"
end
