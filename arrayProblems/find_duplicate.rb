require 'byebug'
def find_duplicate(nums)
  DuplicateFinder.new(nums).find_duplicate
end

class DuplicateFinder
  attr_reader :nums, :sum, :excess
  def initialize(nums)
    @nums = nums
    @sum = nums.inject(0, :+)
    @excess = sum - expected_sum_upto_n(nums.length - 1)
  end

  def actual_sum_between(low, high)
    nums.select { |i| i >= low && i <= high }.inject(0, :+)
  end

  def expected_sum_between(low, high)
    expected_sum_upto_n(high) - expected_sum_upto_n(low - 1)
  end

  def expected_sum_upto_n(n)
    n * (n + 1) / 2
  end

  def find_duplicate
    base = check_bases_cases.call
    return base if base

    find_duplicate_without_base

  end

  def find_duplicate_without_base
    low = 1
    high = nums.length - 1
    mid = (low + high) / 2

    until low == high do
      actual_low = actual_sum_between(low, mid)
      actual_high = actual_sum_between(mid, high)
      expected_low = expected_sum_between(low, mid)
      expected_high = expected_sum_between(mid, high)
      if actual_low == expected_low
        #duplicate cannot be in this range
        low = mid
      elsif actual_high == expected_high
        #duplicate cannot be in top of range
        high = mid
      elsif actual_low < expected_low
        #low value is replacing higher value within low range,
        #or high range value is replacing values in low range
        if actual_high < expected_high
          #number from low range in high range
          high = mid
        else
          #number from range in low range
          low = mid
        end
      else
        #low value is replacing high vaue within low range
        high = mid
      end

      if high - low == 1
        if is_duplicate?(high)
          low = high
        elsif is_duplicate?(low)
          high = low
        else
          raise StandardError.new('converged to wrong answer')
        end
      end

      mid = (low + high) / 2
    end
    mid
  end

  def is_duplicate?(num)
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
    end
  end
end
