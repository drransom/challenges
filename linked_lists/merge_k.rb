require_relative 'linked_list_problems'

def merge_k_lists(lists = [])
  current_nodes = lists.dup
  remove_invalid_data!(current_nodes)
  return nil if current_nodes.empty?
  current_nodes.sort! { |a, b| a.val <=> b.val }
  first, current_index = find_min(current_nodes)
  current_node = first
  until current_nodes.empty?
    previous_node = current_node
    current_node, current_index = find_min(current_nodes)
    previous_node.next = current_node unless current_node.equal?(first)
    current_nodes[current_index] = current_node.next
    if current_node.next
      replace_positions!(current_nodes, current_index)
    else
      current_nodes.compact!
    end
  end
  first
end

def find_min(array)
  [array[0], 0]
end

def replace_positions!(nodes, start_index)
  print_nodes = Proc.new do
    puts nodes.map { |node| node ? node.value : 'no node' }.to_s
  end
  current_node = nodes[start_index]
  min_index = [start_index - 1, 0].max
  max_index = [start_index + 1, nodes.length - 1].min
  while (current_node.val < nodes[min_index].val)
    nodes[min_index], nodes[min_index + 1] = nodes[min_index + 1], nodes[min_index]
    min_index = [min_index - 1, 0].max
  end
  while (current_node.val > nodes[max_index].val)
    nodes[max_index], nodes[max_index - 1] = nodes[max_index - 1], nodes[max_index]
    max_index = [max_index + 1, nodes.length - 1].min
  end
end


def remove_invalid_data!(lists)
  lists.map! do |list|
    if list.is_a?(Array) && list.empty?
      nil
    elsif list.is_a?(Array)
      remove_invalid_data!(list[0])
    else
      list
    end
  end
  lists.compact!
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
#
node1a = DLLNode.new(1)
node1b = DLLNode.new(2)
node1c = DLLNode.new(2)
node1a.child = node1b
node1b.child = node1c
node2a = DLLNode.new(1)
node2b = DLLNode.new(1)
node2a.child = node2b
node2c = DLLNode.new(2)
node2b.child = node2c

# node3a = DLLNode.new(8)
def print_list(node)
  output = []
  while node
    output << node.val
    node = node.child
  end
  puts output.to_s
end
merge_k_lists([node1a, node2a])
