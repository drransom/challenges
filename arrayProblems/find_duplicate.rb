require 'byebug'
def find_duplicate(nums)
  DuplicateFinder.new(nums).find_duplicate
end

class DuplicateFinder
  attr_reader :nums
  def initialize(nums)
    @nums = nums
  end


  def find_duplicate
    base = check_bases_cases.call
    return base if base

    find_duplicate_without_base

  end

  def find_duplicate_without_base
    RangeStatusChecker.new(nums).find_duplicate
  end

  def check_bases_cases
    lambda do
      return 0 if nums.length == 0
      return 1 if nums.length == 1
    end
  end
end

class RangeStatusChecker
  attr_accessor :nums, :low, :high, :mid

  def initialize(nums)
    @nums = nums
    @low = 1
    @high = nums.length - 1
    update_mid
  end

  def update_mid
    @mid = ( high + low ) / 2
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
    until low == high
      update_range
      check_convergence_off_one
      update_mid
    end
    mid
  end

  def check_convergence_off_one
    if high - low == 1
      if is_duplicate?(high)
        @low = high
      elsif is_duplicate?(low)
        @high = low
      else
        raise StandardError.new('converged to wrong answer')
      end
    end
  end


  def update_range
    if determine_range == :low
      @high = mid
    else
      @low = mid
    end
  end

  def determine_range
    actual_low = actual_sum_between(low, mid)
    actual_high = actual_sum_between(mid, high)
    expected_low = expected_sum_between(low, mid)
    expected_high = expected_sum_between(mid, high)

    if actual_low == expected_low
      #duplicate cannot be in this range
      :high
    elsif actual_high == expected_high
      #duplicate cannot be in top of range
      :low
    elsif actual_low < expected_low
      #low value is replacing higher value within low range,
      #or high range value is replacing values in low range
      if actual_high < expected_high
        #number from low range in high range
        :low
      else
        #number from high range in low range
        :high
      end
    else
      #low value is replacing high vaue within low range
      :low
    end
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

end

puts find_duplicate([1, 2, 2])
