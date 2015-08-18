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
end
