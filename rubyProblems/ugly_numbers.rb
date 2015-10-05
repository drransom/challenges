require 'set'

def nth_ugly_number(n)
  return nil if n <= 0
  finder = UglyNumberFinder.new
  finder.find_nth_ugly(n)
end

class UglyNumberFinder
  attr_accessor :uglies, :visited, :indices
  def initialize(indices = { 2 => 0, 3 => 0, 5 => 0 })
    @visited = Set.new([1])
    @uglies = [1]
    @indices = indices
  end

  def increment_indices
    indices.each_key do |value|
      increment_index(value) while visited.include?(uglies[indices[value]] * value)
    end
  end

  def increment_index(value)
    indices[value] += 1
  end

  def find_next_ugly
    increment_indices
    increments = []
    indices.each do |num, index|
      increments << num * uglies[index]
    end
    return increments.min
  end

  def update_uglies!
    next_ugly = find_next_ugly
    uglies << next_ugly
    visited << next_ugly
  end

  def find_nth_ugly(n)
    while uglies.length < n do
      update_uglies!
    end
    uglies[n-1]
  end
end



puts nth_ugly_number(10)
