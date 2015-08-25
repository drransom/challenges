class SelfBalancingBinarySearchTree
  attr_accessor :root
  def initialize
    @root = NullBSTNode.new
  end

  def add_element(value, data = nil)
    if root.is_a?(NullBSTNode)
      @root = BSTNode.new(value, data)
    else
      new_node = @root.find_and_create_node_for(value, data)
    end
    value
  end

  def height
    root.height
  end

  def find_data(value)
    root.find_node(value).data
  end

  def include?(value)
    !root.find_node(value).is_a?(NullBSTNode)
  end

  def each
    return enum_for(:each) unless block_given?
    self.to_a.each do |node|
      yield(node.value, node.data)
    end
  end

  def to_a
    output = []
    root.push_values(output)
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

  def find_and_create_node_for(new_value, data = nil)
    side = new_value < value ? "left" : "right"
    node = self.send((side + "_child"))
    if node.is_a?(NullBSTNode)
      new_node = BSTNode.new(new_value, data)
      new_node.set_parent(self)
      self.send("set_" + side + "_child", new_node)
    else
      node.find_and_create_node_for(new_value, data)
    end
  end

  def set_data(new_data)
    @data = new_data
    self
  end

  def find_node(query_value)

    if value == query_value
      self
    elsif query_value < value
      left_child.find_node(query_value)
    else
      right_child.find_node(query_value)
    end
  end

  def push_values(output)
    @left_child.push_values(output) if has_left_child?
    output << self
    @right_child.push_values(output) if has_right_child?
    output
  end


  def has_left_child?
    @left_child.is_a?(BSTNode)
  end

  def has_right_child?
    @right_child.is_a?(BSTNode)
  end


  protected

  def set_value(new_value)
    @value = new_value
    self
  end

  def update_height_and_balance!
    @balance = @left_child.height - @right_child.height
    @height = [@left_child.height, @right_child.height].max + 1

    rebalance! unless balanced?

    @parent.update_height_and_balance! if @parent
  end

  def balanced?
    @balance.abs <= 1
  end

  def rebalance!
    if @balance > 1


    elsif @balance < 1
    end
  end

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

  def data
    nil
  end

  def find_node(query_value)
    self
  end

  def push_values(output)
    output
  end

end
