class SBBST
end

class BSTNode
  attr_reader :left_child, :right_child, :parent
  
  def initialize(options = {})
    @left_child = options[:left_child]
    @right_child = options[:right_child]
    @parent = options[:parent]
  end
end
