def contains_nearby_almost_duplicate(nums, idx_diff, value_diff)
  queue = MinMaxStackQueue.new
  check_inclusion = construct_inclusion_proc(queue, value_diff)
  nums.each_with_index do |num, index|
    queue.shift if index > idx_diff
    return true if check_inclusion.call(num)
    queue << num
  end
  false
end

def construct_inclusion_proc(queue, value_diff)
  Proc.new do |num|
    if queue.empty?
      false
    elsif (num - queue.max).abs <= value_diff
      true
    elsif (num - queue.min).abs <= value_diff
      true
    elsif queue.max >= num && queue.min <= num
      queue.any? do |el|
        (el - num).abs <= value_diff
      end
    else
      false
    end
  end
end

class MinMaxStack < Array
  def initialize(*args)
    @min = []
    @max = []
    super(args)
  end

  def push(el)
    if self.empty?
      @min << el
      @max << el
    else
      @min << [@min[-1], el].min
      @max << [@max[-1], el].max
    end
    super(el)
  end

  def max
    self.empty? ? super : @max[-1]
  end

  def min
    self.empty? ? super : @min[-1]
  end

  def self.apply_alias
    alias_method :<<, :push
  end

  def pop
    @max.pop
    @min.pop
    super
  end

  apply_alias
end

class StackQueue
  def initialize
    @stack = []
    @queue = []
  end

  def push(el)
    @stack << el
  end

  def shift
    if @queue.empty?
      @queue << @stack.pop until @stack.empty?
    end
    @queue.pop
  end

  def pop
    if @stack.empty?
      @stack << @queue.pop until @queue.empty?
    end
    @stack.pop
  end

  def length
    @queue.length + @stack.length
  end

  def empty?
    @queue.empty? && @stack.empty?
  end

  def self.apply_alias
    alias_method :<<, :push
  end

  def any?(&prc)
    @queue.any? { |el| prc.call(el) } || @stack.any? { |el| prc.call(el) }
  end

  apply_alias
end

class MinMaxStackQueue < StackQueue
  def initialize
    @stack = MinMaxStack.new
    @queue = MinMaxStack.new
  end

  def min
    if @queue.empty?
      @stack.min
    elsif @stack.empty?
      @queue.min
    else
      [@queue.min, @stack.min].min
    end
  end

  def max
    if @queue.empty?
      @stack.max
    elsif @stack.empty?
      @queue.max
    else
      [@queue.max, @stack.max].max
    end
  end

  apply_alias
end
