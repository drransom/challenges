require 'byebug'
class TreeNode
  attr_accessor :val, :left, :right
  def initialize(val)
    @val = val
    @left, @right = nil, nil
  end
end

def max_path_sum(root = nil)
  if root.nil?
    0
  else
    PathSumFinder.new(root).max_path_sum
  end
end

class PathSumFinder
  attr_accessor :best_terminal, :best_non_terminal
  attr_reader :root, :parent

  def initialize(root = nil, parent = nil)
    @root = root
    @parent = parent
  end

  def max_path_sum
    return 0 if root.nil?
    update_best_sum
    [best_terminal, best_non_terminal].max
  end

  def update_best_sum
    # debugger
    if root.nil?
      update_nil_sum
      return
    elsif root.left && root.right
      left = PathSumFinder.new(root.left, root)
      right = PathSumFinder.new(root.right, root)
    elsif root.left
      left = PathSumFinder.new(root.left, root)
      right = NullPathSumFinder.new
    elsif root.right
      right = PathSumFinder.new(root.right, root)
      left = NullPathSumFinder.new
    else
      right = NullPathSumFinder.new
      left = NullPathSumFinder.new
    end
    left.update_best_sum
    right.update_best_sum

    @best_non_terminal = [left.best_non_terminal + root.val,
                         right.best_non_terminal + root.val,
                         root.val].max
    @best_terminal = [left.best_terminal,
                     right.best_terminal,
                     best_non_terminal,
                     left.best_non_terminal + right.best_non_terminal + root.val].max
  end

  def update_nil_sum
    if parent
      @best_terminal, @best_non_terminal = parent.val, parent.val
    elsif root
      @best_terminal, @best_non_terminal = root.val, root.val
    else
      @best_terminal, @best_non_terminal = 0, 0
    end
  end
end

class NullPathSumFinder
  attr_accessor :best_terminal, :best_non_terminal
  def initialize
    @best_terminal, @best_non_terminal = -Float::INFINITY, -Float::INFINITY
  end

  def update_best_sum
  end
end
