class MinMaxStack < Array
  def initialize(*args)
    @min = []
    @max = []
    super(args)
  end

  def push (new)
    if empty?
      @min << new
      @max << new
    else
      @min << [new, @min[-1]].min
      @max << [new, @max[-1]].max
    end
    super(new)
  end

  def << (new)
    push(new)
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

  def move_stack_to_queue
    if @queue.empty?
      @queue << @stack.pop until @stack.empty?
    end
  end
end
