class MinMaxStack < Array
  def initialize(*args)
    @min = []
    @max = []
    super(args)
  end

  def push (new_value)
    if empty?
      @min << new_value
      @max << new_value
    else
      @min << [new_value, @min[-1]].min
      @max << [new_value, @max[-1]].max
    end
    super(new_value)
  end

  def << (new_value)
    push(new_value)
  end

  def max
    @max.empty? ? nil : @max[-1]
  end

  def min
    @min.empty? ? nil : @min[-1]
  end

  def pop
    @min.pop
    @max.pop
    super
  end

  def sort
    (@queue.reverse + @stack).sort
end

class MinMaxStackQueue
  def initialize
    @stack = MinMaxStack.new
    @queue = MinMaxStack.new
  end

  def push(val)
    @stack << val
  end

  def max
    [@stack.max, @queue.max].compact.max
  end

  def min
    [@stack.min, @queue.min].compact.min
  end

  def shift
    move_stack_to_queue if @queue.empty?
    @queue.pop
  end

  def length
    @stack.length + @queue.length
  end

  def move_stack_to_queue
    if @queue.empty?
      @queue << @stack.pop until @stack.empty?
    end
  end

  def [](num)
    return nil if length == 0
    num = num % length
    if num < @queue.length
      @queue[num - length]
    else
      @stack[num - @queue.length]
    end
  end

  def each(&prc)
    length.times do |index|
      prc.call(self[index])
    end
  end
end

end
