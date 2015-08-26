require 'byebug'

class SelfBalancingBinarySearchTree
  attr_accessor :root
  def initialize
    @root = NullBSTNode.new
  end

  def add_element(value, data = nil)
    if root.is_a?(NullBSTNode)
      new_node = BSTNode.new(self, value, data)
      @root = new_node
    else
      new_node = @root.find_and_create_node_for(value, data)
    end
    new_node
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

  def possibly_change_root!(possible_old_root, possible_new_root)
     @root = possible_new_root if @root == possible_old_root
   end



end

class BSTNode
  attr_reader :left_child, :right_child, :parent, :value, :height, :balance, :data

  def initialize(tree, value, data = nil)
    @tree = tree
    @value = value
    @data = data
    @left_child = NullBSTNode.new
    @right_child = NullBSTNode.new
    @balance = 0
    @height = 0
  end

  def set_left_child(new_child, options = {})
    @left_child = new_child
    update_height_and_balance! unless options[:avoid_rebalance]
    new_child
  end

  def set_right_child(new_child, options = {})
    @right_child = new_child
    update_height_and_balance! unless options[:avoid_rebalance]
    new_child
  end

  def set_parent(new_parent)
    @parent = new_parent
    self
  end

  def find_and_create_node_for(new_value, data = nil)
    side = new_value < value ? "left" : "right"
    node = self.send((side + "_child"))
    if node.is_a?(NullBSTNode)
      new_node = BSTNode.new(@tree, new_value, data)
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

  def rotate_right!
    new_parent = left_child
    old_parent = parent
    new_left = new_parent.right_child

    new_parent.set_parent(old_parent)
    set_parent(new_parent)
    set_left_child(new_left, avoid_rebalance: true)
    new_parent.set_right_child(self, avoid_rebalance: true)

    @tree.possibly_change_root!(self, new_parent)
  end

  def rotate_left!
    new_parent = right_child
    old_parent = parent
    new_right = new_parent.left_child

    new_parent.set_parent(old_parent)
    set_parent(new_parent)
    set_right_child(new_right, avoid_rebalance: true)
    new_parent.set_left_child(self, avoid_rebalance: true)

    @tree.possibly_change_root!(self, new_parent)
  end

  protected

  def set_value(new_value)
    @value = new_value
    self
  end

  def update_height_and_balance!(options = {})
    @balance = @left_child.height - @right_child.height
    @height = [@left_child.height, @right_child.height].max + 1

    rebalance! unless balanced? || options[:avoid_rebalance]

    @parent.update_height_and_balance!(options) if @parent && !options[:avoid_rebalance]
  end

  def balanced?
    @balance.abs <= 1
  end

  def rebalance!
    if @balance > 1
      rotate_right!
    elsif @balance < 1
      rotate_left!
    end
    update_height_and_balance!(avoid_rebalance: true)
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
