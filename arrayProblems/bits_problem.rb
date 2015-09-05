# you can write to stdout for debugging purposes, e.g.
# puts "this is a debug message"

def solution(a)
  return [] if a.empty?
  target = -zero_sum(a)
  output = a
  sum = 0
  i = 0
  while sum != target
    if (target - sum) % (-2) ** i != 0
      output << 1
      sum +=1
    else

    end
  end
end

def zero_sum(a)
  sum = 0
  a.each_with_index do |elem, i|
    sum += elem * ((-2) ** i)
  end
  sum
end

x = [1, 1, 0, 1, 0, 1, 1]
y = x.dup
y.shift
z = x.dup
z.unshift(0)

puts zero_sum(x)
puts zero_sum(y)
puts zero_sum(z)
