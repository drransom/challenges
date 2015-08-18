require 'byebug'
class DoublyLinkedList
  include Enumerable

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

  #deletes by value
  def delete(value)
    last_deleted = nil
    traverse_original_each do |node|
      if node.value == value
        delete_node!(node)
        last_deleted = node
      end
    end
    last_deleted ? last_deleted.value : nil
  end

  def each
    return enum_for(:each) unless block_given?

    current = first_node
    while current
      yield current.value
      current = current.child
    end
    self
  end

  def each_node
    return enum_for(:each_node) unless block_given?
    current = first_node
    while current
      yield current
      current = current.child
    end
    self
  end

  def ==(other_list)
    return false unless length == other_list.length
    self.each_with_index do |elem, idx|
      return false unless elem == other_list[idx]
    end
    true
  end

  def to_a
    [].tap do |arr|
      self.each do |elem|
        arr << elem
      end
    end
  end

  def to_s
    to_a.to_s
  end

  def hash
    arr_hash_val = to_a.hash
    str_hash_val = to_s.hash
    arr_hash_val ^ str_hash_val
  end

  def to_h
    to_a.to_h
  end

  def to_hash
    to_h
  end

  def map
    return enum_for(:map) unless block_given?

    new_list = DoublyLinkedList.new
    self.each do |value|
      new_list.push(yield value)
    end
    new_list
  end

  def find_node_at_index(idx)
    if idx >= 0
      get_non_negative_index(idx)
    else
      get_negative_index(idx)
    end
  end

private
  attr_accessor :first_node, :last_node


  def get_non_negative_index(idx)
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
    elsif node.equal?(@first_node)
      delete_first_node!
    elsif node.equal?(@last_node)
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

  def traverse_original_each &prc
    return unless block_given?
    start = @first_node
    finish = @last_node
    current_node = @first_node
    while current_node
      next_node = current_node.child
      prc.call(current_node)
      current_node = next_node
    end
  end
end

class DLLNode
  attr_accessor :parent, :child, :value
  def initialize(value)
    @value = value
    @parent = nil
    @child = nil
  end

  def ==(other)
    if other.is_a?(DLLNode)
      self.value == other.value
    else
      self.value == other
    end
  end

  def hash
    value.hash
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
