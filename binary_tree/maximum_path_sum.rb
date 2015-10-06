class TreeNode
    attr_accessor :val, :left, :right
    def initialize(val)
        @val = val
        @left, @right = nil, nil
    end
end

def max_path_sum(root = nil)
  return 0 if root.nil?
end
