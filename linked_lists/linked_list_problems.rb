require 'byebug'
class DoublyLinkedList
  attr_reader :length

  def first
    @first_node ? @first_node.value : nil
  end

  def last
    @last_node ? @last_node.value : nil
  end

  def initialize(items = [])
    @first_node = nil
    @last_node = nil
    @length = 0
    items.each { |item| push(item) }
  end

  def empty?
    length == 0
  end

  def push(value)
    node = DLLNode.new(value)
    node.parent = last_node
    if @last_node
      @last_node.child = node
    else
      @first_node = node
    end
    @last_node = node
    @length += 1
    node.value
  end

  def unshift(value)
    node = DLLNode.new(value)
    node.child = @first_node
    if @first_node
      @first_node.parent = node
    else
      @last_node = node
    end
    @first_node = node
    @length += 1
    node.value
  end

  def pop
    if @last_node
      value = @last_node.value
      @last_node = @last_node.parent
      @last_node.child = nil
    else
      value = nil
    end
    @length -= 1
    value
  end

  def shift
    if @first_node
      value = @first_node.value
      @first_node = @first_node.child
      @first_node.parent = nil
    else
      value = nil
    end
    @length -= 1
    value
  end

  def [](idx)
    find_node_at_index(idx).value
  end

  def []=(idx, value)
    node = find_node_at_index(idx)
    if node.is_a?(NullNode)
      raise IndexError.new("index #{idx} outside of list bounds: -#{length}...#{length}")
    else
      node.value = value
    end
  end

  def <<(value)
    push(value)
  end

private
  attr_accessor :first_node, :last_node

  def find_node_at_index(idx)
    if idx >= 0
      get_non_negative_index(idx)
    else
      get_negative_index(idx)
    end
  end

  def get_non_negative_index(idx)
    # debugger
    return NullNode.new if idx >= length || length == 0
    current_node = @first_node
    idx.times { current_node = current_node.child }
    current_node
  end

  def get_negative_index(idx)
    return NullNode.new if -idx > length || length == 0
    current_node = @last_node
    (-idx - 1).times { current_node = current_node.parent }
    current_node
  end
end

class DLLNode
  attr_accessor :parent, :child, :value
  def initialize(value)
    @value = value
    @parent = nil
    @child = nil
  end
end

class NullNode
  def value
    nil
  end

  def parent
    nil
  end

  def child
    nil
  end
end
