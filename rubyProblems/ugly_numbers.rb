require 'set'

def nth_ugly_number(n)
    return nil if n <= 0
    visited = Set.new
    visited << 1
    uglies = [1];

    add_number = Proc.new do |number|
      unless visited.include?(number)
        uglies << number
        visited << number
      end
    end

    current_index = 0
    while uglies.length < n do
      current_num = uglies[current_index]
      [2, 3, 5].each { |num| add_number.call(current_num * num) }
      current_index += 1
    end
    puts uglies.to_s
    uglies.sort[n-1]
end

puts nth_ugly_number(500)
