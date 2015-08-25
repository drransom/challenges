class SelfBalancingBinarySearchTree
  attr_accessor :root
  def initialize
    @root = nil
  end

  def add_element(value)
    if !@root
      @root = BSTNode.new(value)
    end
    value
  end

  def height
    @root ? root.height : -1
  end
end

class BSTNode
  attr_reader :left_child, :right_child, :parent, :value, :height, :balance

  def initialize(value = nil)
    @value = value
    @left_child = NullBSTNode.new
    @right_child = NullBSTNode.new
    @balance = 0
    @height = 0
  end

  def set_left_child(new_child)
    @left_child = new_child
    update_height
    update_balance
    self
  end

  def set_right_child(new_child)
    @right_child = new_child
    update_height
    update_balance
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

  def update_balance
    @balance = @left_child.height - @right_child.height
  end

  def update_height
    @height = [@left_child.height, @right_child.height].max + 1
  end

  def balanced?
    @balance.abs <= 1
  end

  class NullBSTNode
    def height
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
