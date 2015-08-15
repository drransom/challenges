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

  def <<(value)
    push(value)
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

  def insert(index, value)
    if index == length || index == - (length + 1)
      push(value)
    else
      node = find_node_at_index(index)
      if node.is_a?(NullNode)
        message = if length == 0
          "cannot index into empty list"
        else
          "index #{index} outside of list bounds: -#{length}...#{length}"
        end
        raise IndexError.new(message)
      else
        insert_before_node(node, value)
        value
      end
    end
  end

  def delete_at(index)
    node = find_node_at_index(index)
    if node.is_a?(NullNode)
      message = if length == 0
        "cannot index into empty list"
      else
        "index #{index} outside of list bounds: -#{length}...#{length}"
      end
      raise IndexError.new(message)
    end
    delete_node!(node)
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

  def insert_before_node(node, value)
    new_node = DLLNode.new(value)

    if node.parent
      node.parent.child = new_node
    else
      @first_node = new_node
    end

    new_node.child = node
    new_node.parent = node.parent
    node.parent = node
    node.child = new_node
    @length += 1
  end

  def delete_node!(node)
    if length <= 1
      empty_list!
    elsif node == @first_node
      delete_first_node!
    elsif node == @last_node
      delete_last_node!
    else
      delete_middle_node!(node)
    end
    node.value
  end

  def delete_first_node!
    case length
    when 0
      nil
    when 1
      empty_list!
    else
      node = @first_node
      @first_node = node.child
      node.child.parent = nil
      @length -= 1
    end
  end

  def delete_last_node!
    case length
    when 0
      nil
    when 1
      empty_list!
    else
      node = @last_node
      @last_node = node.parent
      @last_node.child = nil
      @length -= 1
    end
  end

  def delete_middle_node!(node)
    node.parent.child = node.child
    node.child.parent = node.parent
    @length -= 1
  end

  def empty_list!
    @first_node = nil
    @last_node = nil
    @length = 0
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
