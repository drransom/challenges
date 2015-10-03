require 'byebug'


class BinarySearchTree
  attr_accessor :root
  def initialize(node_type = BSTNode)
    @node_type = node_type
    @root = NullBSTNode.new
  end

  def add_element(value, data = nil)
    if root.is_a?(NullBSTNode)
      new_node = @node_type.new(self, value, data)
      @root = new_node
    else
      new_node = @root.find_and_create_node_for(value, data)
    end
    new_node
  end

  def display_values
    current_row = [@root]
    next_row = []
    empty = false

    until empty
      height = current_row.map { |node| (node ? node.height : -1) }.max
      separator = ' ' * (2 ** (height + 1))
      empty = true
      output_string = ''
      current_row.each do |node|
        if node && (node.has_left_child? || node.has_right_child?)
          empty = false
        end
        next_row << (node ? node.left_child : nil)
        next_row << (node ? node.right_child : nil)
      end

      output_string = current_row.inject(separator) do |memo, node|
        memo + (node && node.value ? node.value.to_s : " ") + separator
      end

      puts output_string
      current_row = next_row
      next_row = []
    end
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

  def delete(value)
    node_to_delete = root.find_node(value)
    node_to_delete.delete! if node_to_delete
    value
  end
end

class SelfBalancingBinarySearchTree < BinarySearchTree
  def initialize
    super(SBBSTNode)
  end
end

class BSTNode
  def initialize(tree, value, data = nil)
    @tree = tree
    @value = value
    @data = data
    @left_child = NullBSTNode.new
    @right_child = NullBSTNode.new
  end
end

class SBBSTNode < BSTNode
  attr_reader :left_child, :right_child, :parent, :height, :balance
  attr_accessor :value, :data

  def initialize(tree, value, data = nil)
    @balance = 0
    @height = 0
    super(tree, value, data)
  end

  def set_left_child(new_child, options = {})
    @left_child = new_child
    new_child.update_height_and_balance!(avoid_rebalance: true)
    update_height_and_balance! unless options[:avoid_rebalance]
    new_child
  end

  def set_right_child(new_child, options = {})
    @right_child = new_child
    new_child.update_height_and_balance!(avoid_rebalance: true)
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
      new_node = SBBSTNode.new(@tree, new_value, data)
      new_node.set_parent(self)
      self.send("set_" + side + "_child", new_node)
    else
      node.find_and_create_node_for(new_value, data)
    end
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
    @left_child.is_a?(self.class)
  end

  def has_right_child?
    @right_child.is_a?(self.class)
  end

  def rotate_right!
    new_parent = left_child
    old_parent = parent
    new_left = new_parent.right_child

    new_parent.set_parent(old_parent)
    set_parent(new_parent)
    set_left_child(new_left, avoid_rebalance: true)
    new_parent.set_right_child(self, avoid_rebalance: true)

    update_old_parent!(old_parent, new_parent)
    new_left.set_parent(self)

    @tree.possibly_change_root!(self, new_parent)
  end

  def rotate_left!
    new_parent = right_child
    old_parent = parent
    new_right = new_parent.left_child

    new_parent.set_parent(old_parent)
    set_parent(new_parent)
    set_right_child(new_right, avoid_rebalance: true)
    new_right.set_parent(self)
    new_parent.set_left_child(self, avoid_rebalance: true)

    update_old_parent!(old_parent, new_parent)

    @tree.possibly_change_root!(self, new_parent)
  end


  def update_old_parent!(old_parent, new_parent)
    if old_parent
      old_parent.replace_child(self, new_parent, avoid_rebalance: true)
    end
  end

  def delete!
    children = [left_child, right_child].select { |child| child.is_a?(self.class) }
    if children.length == 0
      destroy_self!
    elsif children.length == 1 && parent
      replace_self_with_child(children[0])
    elsif children.length == 1
      replace_info_and_remove_old_leaf(children[0])
    else
      child = (balance < 0) ? left_child : right_child
      elevate_leaf_from_bottom!(child)
    end
  end

  def has_child?
    left_child.is_a?(self.class) || right_child.is_a?(self.class)
  end

  protected

  def elevate_leaf_from_bottom!(child)
    case child
    when left_child
      replacement = child.find_highest_below
    when right_child
      replacement = child.find_lowest_below
    end
    replace_info_and_remove_old_leaf(replacement)
  end

  def find_lowest_below
    has_left_child? ? left_child.find_lowest_below : self
  end

  def find_highest_below
    has_right_child? ? right_child.find_highest_below : self
  end

  def replace_self_with_child(child)
    parent.replace_child(self, child)
    destroy_self!
  end

  def replace_info_and_remove_old_leaf(other_node)
    replace_info_with(other_node)
    other_node.delete!
  end

  def destroy!
    if parent
      parent.replace_child(self, NullBSTNode.new) if parent
    elsif !has_child? #should mean that the tree is empty
      @tree.possibly_change_root!(self, nil)
    end

    #clear pointers to other objects
    @value, @data, @parent, @left_child, @right_child = nil, nil, nil, nil, nil
  end

  def replace_info_with(other_node)
    @value = other_node.value
    @data = other_node.data
  end


  def replace_child(old_child, new_child, options = {})
    case old_child
    when left_child
      set_left_child(new_child, options)
    when right_child
      set_right_child(new_child, options)
    end
  end

  def update_height_and_balance!(options = {})
    new_balance = @left_child.height - @right_child.height
    new_height = [@left_child.height, @right_child.height].max + 1

    changed = @balance != new_balance || @height != new_height
    @balance = new_balance
    @height = new_height

    rebalance! unless balanced? || options[:avoid_rebalance]

    @parent.update_height_and_balance!(options) if changed && @parent
  end

  def balanced?
    @balance.abs <= 1
  end

  def rebalance!
    if @balance > 1
      left_child.rotate_left! if left_child.balance < 0
      rotate_right!
    elsif @balance < 1
      right_child.rotate_right! if right_child.balance > 0
      rotate_left!
    end
    update_height_and_balance!(avoid_rebalance: true)
  end

  private

  def destroy_self!
    destroy!
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

  def update_height_and_balance!(options = {})
  end

  def has_left_child?
    false
  end

  def has_right_child?
    false
  end

  def left_child
    nil
  end

  def right_child
    nil
  end

  def set_parent(node)
  end

end
