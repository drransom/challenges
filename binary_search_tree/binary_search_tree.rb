class SelfBalancingBinarySearchTree
end

class BSTNode
  attr_reader :left_child, :right_child, :parent, :value

  def initialize(options = {})
    @left_child = options[:left_child]
    @right_child = options[:right_child]
    @parent = options[:parent]
    @value = options[:value]
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


end