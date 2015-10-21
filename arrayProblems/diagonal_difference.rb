# Enter your code here. Read input from STDIN. Print output to STDOUT

def diagonal_difference(array)
  (sum_first_diagonal(array) - sum_second_diagonal(array)).abs
end

def get_diagonal_difference_from_stdin(numlines)
  array = get_array_matrix_from_stdin(numlines)
  diagonal_difference(array)
end

def get_array_matrix_from_stdin(numlines)
  [].tap do |arr|
    numlines.times do
      line = gets.strip
      arr << line.split(' ').map { |num_str| num_str.to_i }
    end
  end
end

def sum_first_diagonal(arr)
  arr.each_with_index.inject(0) do |sum, (line, idx) |
    sum + line[idx]
  end
end

def sum_second_diagonal(arr)
  arr.each_with_index.inject(0) do |sum, (line, idx)|
    sum + line[-idx - 1]
  end
end


puts get_diagonal_difference_from_stdin(gets.chomp.to_i)
