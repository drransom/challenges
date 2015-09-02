def solution(a)
    return -1 if a.length <= 1

    sum = a.inject(:+)
    sum_array = []
    reverse_sum_array = []
    equilibrium_indices = []
    length = a.length
    a.length.times do |i|
        if i == 0
            sum_array << 0
            reverse_sum_array << sum - a.first
        elsif i == length - 1
            sum_array << sum - a.last
            reverse_sum_array << 0
        else
            sum_array << sum_array.last + a[i-1]
            reverse_sum_array << reverse_sum_array.last - a[i]
        end
    end
    puts "sum_array = #{sum_array}"
    puts "reverse sum array = #{reverse_sum_array}"
    (1..a.length - 1).each do |i|
        puts "sum_array[#{i}] = #{sum_array[i]}"
        puts "reversed_sum_array[#{i}] = #{reverse_sum_array[i]}"
        equilibrium_indices << i if sum_array[i] == reverse_sum_array[i]
    end
    equilibrium_indices.empty? ? -1 : equilibrium_indices
end

puts "#{solution([5, 2, 1, 3, 1, 0, 0, -5])}"
