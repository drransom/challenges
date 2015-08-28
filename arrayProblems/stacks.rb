class SortStack
  def initialize(input = [])
    @contents = []
    input.each { |elem| @contents << elem }
  end

  def push(elem)
    contents.push(elem)
    elem
  end

  def <<(elem)
    push(elem)
  end

  def pop
    contents.pop
  end

  def peek
    contents.last
  end

  def length
    contents.length
  end

  def empty?
    contents.empty?
  end

  def ==(other_stack)
    return false unless other_stack.is_a?(SortStack)
    contents == other_stack.contents
  end

  def hash
    [contents].hash
  end

  protected

  def contents
    @contents
  end
end
