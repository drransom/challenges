# you can write to stdout for debugging purposes, e.g.
# puts "this is a debug message"

def weirdIndex(x, a)
  return -1 if a.length <= 1
  right_index_function = Proc.new { |x| x}
  left_index_function = Proc.new {|x| x - 1}
  right_pointer = Pointer.new({direction: -1,
                               index: a.length - 1,
                               array: a,
                               comparison: Proc.new {|i| i != x },
                               index_function: right_index_function
                             })
  left_pointer = Pointer.new({direction: 1,
                              index: 1,
                              array: a,
                              comparison: Proc.new {|i| i == x },
                              index_function: left_index_function
                            })
  has_flipped = false
  while true do
    old_value = left_pointer.sum
    update_pointer_values(left_pointer, right_pointer)
    if left_pointer.index > right_pointer.index
      left_pointer.index -= 1
      left_pointer.sum = old_value
    end
    if left_pointer.index == right_pointer.index
      if left_pointer.sum == right_pointer.sum
        return left_pointer.index
      else
        just_flipped = update_pointer_directions(left_pointer, right_pointer)
        break if just_flipped && has_flipped
        has_flipped = just_flipped
      end
    end
    move_pointers(left_pointer, right_pointer)
    if left_pointer.index < 0 || right_pointer.index < 0 ||
       left_pointer.index >= a.length || right_pointer.index >= a.length
       break
    end
  end
  -1
end

def update_pointer_values(left_pointer, right_pointer)
  left_pointer.update_value!
  right_pointer.update_value!
end

def move_pointers(left_pointer, right_pointer)
  left_pointer.move!
  right_pointer.move!
end


def update_pointer_directions(left_pointer, right_pointer)
  return_value = false
  if left_pointer.index == right_pointer.index
    if left_pointer.sum > right_pointer.sum
      return_value = left_pointer.direction != -1
      left_pointer.direction = -1
    else
      return_value = right_pointer.direction == 1
      right_pointer.direction = 1
    end
  end

  return_value
end


class Pointer
  attr_accessor :direction, :sum, :index, :array
  def initialize(options)
    @direction = options[:direction]
    @initial_direction = @direction
    @sum = 0
    @index = options[:index]
    @array = options[:array]
    @comparison = options[:comparison]
    @index_function = options[:index_function]
  end

  def update_value!
    @sum += direction * @initial_direction if @comparison.call(array[index_value])
  end

  def move!
    @index += direction
  end

  def index_value
    @index_function.call(index)
  end

  def to_s
    "direction: #{direction}, index: #{index}, sum: #{sum}"
  end
end
