require_relative 'linked_list_problems'

def merge_k_lists(lists = [])
  return nil if lists.empty?
  current_nodes = lists.dup
  first, current_index = find_min(current_nodes)
  current_node = first
  current_nodes[current_index] = first.child
  current_nodes.compact! unless first.child
  until current_nodes.empty?
    previous_node = current_node
    current_node, current_index = find_min(current_nodes)
    previous_node.child = current_node
    # puts "current value is #{current_node ? current_node.value : 'no node'}"
    current_nodes[current_index] = current_node.child
    current_nodes.compact! unless current_node.child
  end
  first
end

def find_min(array)
  index = array.map { |node| node.value }.each_with_index.min[1]
  [array[index], index]
end
