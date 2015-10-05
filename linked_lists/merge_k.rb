require_relative 'linked_list_problems'

def merge_k_lists(lists = [])
  return nil if lists.empty?
  current_nodes = lists.dup
  first, current_index = find_min(current_nodes)
  current_node = first
  current_nodes[current_index] = first.next
  current_nodes.compact! unless first.next
  until current_nodes.empty?
    previous_node = current_node
    current_node, current_index = find_min(current_nodes)
    previous_node.next = current_node
    current_nodes[current_index] = current_node.next
    current_nodes.compact! unless current_node.next
  end
  first
end

def find_min(array)
  index = array.map { |node| node.val }.each_with_index.min[1]
  [array[index], index]
end

class DLLNode
  def val
    @value
  end

  def next
    @child
  end

  def next=(other)
    @child = other
  end
end
