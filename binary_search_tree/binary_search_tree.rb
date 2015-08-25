class SelfBalancingBinarySearchTree
  attr_accessor :root
  def initialize
    @root = nil
  end

  def add_element(value, data = nil)
    if !@root
      @root = BSTNode.new(value, data)
    else
      new_node = @root.find_and_create_node_for(value, data)
    end
  end

  def height
    @root ? root.height : -1
  end

end

class BSTNode
  attr_reader :left_child, :right_child, :parent, :value, :height, :balance, :data

  def initialize(value, data = nil)
    @value = value
    @data = data
    @left_child = NullBSTNode.new
    @right_child = NullBSTNode.new
    @balance = 0
    @height = 0
  end

  def set_left_child(new_child)
    @left_child = new_child
    update_height_and_balance!
    self
  end

  def set_right_child(new_child)
    @right_child = new_child
    update_height_and_balance!
    self
  end

  def set_parent(new_parent)
    @parent = new_parent
    self
  end


  def find_and_create_node_for(key, data = nil)

  end

  def set_data(new_data)
    @data = new_data
    self
  end

  protected

  def set_value(new_value)
    @value = new_value
    self
  end

  def update_height_and_balance!
    @balance = @left_child.height - @right_child.height
    @height = [@left_child.height, @right_child.height].max + 1
    @parent.update_height_and_balance! if @parent
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
