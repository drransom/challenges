class SelfBalancingBinarySearchTree
  def initialize
    @head = nil
  end

  def add_element(value)
    if !@head
      @head = BSTNode.new({ value: value })
    end
    value
  end
end

class BSTNode
  attr_reader :left_child, :right_child, :parent, :value, :balance

  def initialize(options = {})
    @left_child = options[:left_child] || NullBSTNode.new
    @right_child = options[:right_child] || NullBSTNode.new
    @parent = options[:parent]
    @value = options[:value]
    @balance = @right_child.depth - @left_child.depth
    @depth = [@left_child.depth, @right_child.depth].max
  end

  def set_left_child(new_child)
    @left_child = new_child
    self
  end

  def set_right_child(new_child)
    @right_child = new_child
    self
  end

  def set_parent(new_parent)
    @parent = new_parent
    self
  end

  def set_value(new_value)
    @value = new_value
    self
  end

  private

  class NullBSTNode
    def depth
      -1
    end

    def balance
      0
    end

    def value
      nil
    end
  end
end
