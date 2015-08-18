require_relative 'linked_list_problems.rb'
require 'set'

class DoublyLinkedList
  def remove_duplicates!
    seen = Set.new
    self.each_node do |node|
      if seen.include?(node.value)
        delete_node!(node)
      else
        seen << node.value
      end
    end
    self
  end

  def remove_duplicates_without_buffer!
    n = 1
    while n <= self.length
      current_node = self.find_node_at_index(n-1)
      deleted = false
      self.each_node do |node|
        if node == current_node && !current_node.equal?(node)
          delete_node!(node)
          unless deleted
            deleted = true
            n -= 1
          end
        end
      end
      n += 1
    end
    self
  end

  def kth_to_last_without_length(k)
    # purpose is to find the kth to last as this was a singly linked
    # list without known length
    return nil if k < 0
    kth_to_last_node_without_length(k).value
  end

private
  def kth_to_last_node_without_length(k)
    length = count_length
    return NullNode.new if k >= length
    find_node_at_index(count_length - k - 1)
  end

  def count_length
    n = 0
    self.each { n += 1 }
    n
  end
end
