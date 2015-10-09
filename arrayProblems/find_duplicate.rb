require 'byebug'
def find_duplicate(nums)
  DuplicateFinder.new(nums).find_duplicate
end

class DuplicateFinder
  attr_reader :nums, :sum, :excess
  def initialize(nums)
    @nums = nums
    @sum = nums.inject(0, :+)
    @excess = sum - sum_upto_n(nums.length - 1)
  end

  def sum_upto_n(n)
    n * (n + 1) / 2
  end

  def find_duplicate
    return 0 if nums.length == 0
    return 1 if nums.length == 1
    return excess if nums.count(excess) > 1
  end      
end
