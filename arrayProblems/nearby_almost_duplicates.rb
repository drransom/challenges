def contains_nearby_almost_duplicate(nums, idx_diff, value_diff)
  sorter = IndexSorter.new(nums)
  sorter.has_within_bounds?(idx_diff, value_diff)
end

class IndexSorter
  def initialize(nums)
    @sorted = sort_with_index(nums)
  end

  def sort_with_index(nums)
    nums.map.with_index { |num, idx| [num, idx] }.sort_by { |element| element[0] }
  end

  def has_within_bounds?(idx_diff, value_diff)
    return false if idx_diff <= 0 || value_diff < 0
    difference_too_big = Proc.new { |a, b| (a[0] - b[0]).abs > value_diff }
    index_within_bounds = Proc.new { |a, b| (a[1] - b[1]).abs <= idx_diff }
    evaluate_sorted(difference_too_big, index_within_bounds, idx_diff)
  end

  def evaluate_sorted(difference_too_big, index_within_bounds, idx_diff)
    @sorted.each_with_index do |current_element, index|
      end_index = [index + idx_diff, @sorted.length - 1].min
      (index+1..(@sorted.length - 1)).each do |current_index|
        next_element = @sorted[current_index]
        if difference_too_big.call(current_element, next_element)
          break
        else
          return true if index_within_bounds.call(current_element, next_element)
        end
      end
    end
    false
  end

  def construct_diff_proc(idx_diff, value_diff)
    Proc.new do | element1, element2 |
      (element1[0] - element2[0]).abs <= value_diff &&
      (element1[1] - element2[1]).abs <= idx_diff
    end
  end
end
