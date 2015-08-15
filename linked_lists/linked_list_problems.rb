class LinkedList
end

class LinkedListNode
  attr_accessor :parent, :value
  def initialize(value, parent = nil)
    @value = value
    @parent = parent
  end
end
