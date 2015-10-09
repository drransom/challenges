def combination_sum(candidates, target)
  CombinationFinder.new(candidates).find_combinations(target).uniq
end

def combination_sum2(candidates, target)
  CombinationFinder.new(candidates).find_combinations_no_repeats(target).uniq
end

class CombinationFinder
  attr_accessor :candidates
  def initialize(candidates)
    candidates.sort!
    @candidates = candidates
  end

  def find_combinations(target, end_index = nil )
    end_index ||= candidates.length - 1
    current_answer = []
    while end_index >= 0
      current = candidates[end_index]
      if target == current
        current_answer << [current]
      elsif target > current
        new_combinations = find_combinations(target - current, end_index)
        new_combinations.each { |combination| combination << current }
        current_answer += new_combinations
      end
      end_index -= 1
    end
    current_answer
  end

  def find_combinations_no_repeats(target, end_index = nil)
    end_index ||= candidates.length
    end_index -= 1
    current_answer = []
    while end_index >= 0
      current = candidates[end_index]
      if target == current
        current_answer << [current]
      elsif target > current
        new_combinations = find_combinations_no_repeats(target - current, end_index)
        new_combinations.each { |combination| combination << current }
        current_answer += new_combinations
      end
      end_index -= 1
    end
    current_answer
  end

end
