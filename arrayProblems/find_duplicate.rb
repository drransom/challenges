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
    check_bases_cases.call

  end

  def contains_duplicate?(num)
    found = false
    nums.each do |current|
      if current == num
        return true if found
        found = true
      end
    end
    false
  end


  def check_bases_cases
    lambda do
      return 0 if nums.length == 0
      return 1 if nums.length == 1
      return excess if contains_duplicate?(excess)
    end
  end
end
