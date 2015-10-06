class TreeNode
  attr_accessor :val, :left, :right
  def initialize(val)
    @val = val
    @left, @right = nil, nil
  end
end

def sum_numbers(root = nil)
  SumChecker.new(root, 0).sum_numbers
end

class SumChecker
  def initialize(root, current)
    @root = root
    if @root && @root.val
      @current_value = current * 10 + @root.val
    else
      @current_value = 0
    end
  end

  def sum_numbers
    return 0 if @root.nil? || @root.val.nil?

    if @root.left || @root.right
      SumChecker.new(@root.left, @current_value).sum_numbers +
      SumChecker.new(@root.right, @current_value).sum_numbers
    else
      @current_value
    end
  end
end
