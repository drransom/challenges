require 'byebug'

class SortStack
  def initialize(input = [])
    @stack_array = []
    input.each { |elem| @stack_array << elem }
  end

  def to_s
    @stack_array.to_s
  end

  def push(elem)
    stack_array.push(elem)
    elem
  end

  def <<(elem)
    push(elem)
  end

  def pop
    stack_array.pop
  end

  def peek
    stack_array.last
  end

  def length
    stack_array.length
  end

  def empty?
    stack_array.empty?
  end

  def ==(other_stack)
    return false unless other_stack.is_a?(SortStack)
    stack_array == other_stack.stack_array
  end

  def hash
    [stack_array].hash
  end

  def sort &prc
    #procs used in this method
    prc = block_given? ? prc : basic_sort

    greater = Proc.new { |x, y| prc.call(x, y) == 1 }

    swap = Proc.new do |from, to|
      top = from.pop
      from.push(to.pop)
      to.push(top)
    end
    #end proc definitions
    return self if length <= 1
    other_stack = SortStack.new

    current_from, current_to = self, other_stack
    other_stack.push(self.pop) #guaranteed to return

    counter = 0
    loop do
      changed = false
      until current_from.empty?
        if !current_to.empty? && greater.call(self.peek, other_stack.peek)
          swap.call(self, other_stack)
          changed = true
        end
        current_to << current_from.pop
      end
      break unless changed
      counter += 1
      current_from, current_to = current_to, current_from
    end

    push_stack(other_stack)
    self

  end

  def push_stack(other_stack)
    until other_stack.empty?
      self << other_stack.pop
    end
  end

  protected

  def stack_array
    @stack_array
  end

  private

  def basic_sort
    Proc.new do |a, b|
      if a > b
        1
      elsif a == b
        0
      else
        -1
      end
    end
  end
end
