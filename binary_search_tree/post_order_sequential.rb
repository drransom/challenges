require_relative 'binary_search_tree'

class BinarySearchTree
  def post_order_sequential
    @root.post_order_sequential
  end

end

class BSTNode
end

class NullBSTNode
  def post_order_sequential
    []
  end
end
