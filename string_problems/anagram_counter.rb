require 'set'
require 'byebug'
class String
  def count_anagramic_substrings
    AnagramCounter.new(self).count_anagramic_substrings
  end
end

class AnagramCounter < String

  def count_anagramic_substrings
    count = 0
    checked = Set.new
    max_len = self.length - 1
    1.upto(max_len) do |length|
      count += count_anagrams_of_length(length)
    end
    count
  end

  def count_anagrams_of_length(len)
    pattern = SubstringCounter.new(self[0..-1], len)
    current = SubstringCounter.new(self[0..-1], len)
    infinity_counter = 0
    count = 0
    start_idx = 0
    loop do

      count += count_pattern(pattern, start_idx)
      break unless pattern.can_slide?

      infinity_counter += 1
      if infinity_counter > 1000
        puts "infinite loop"
        break
      end

      start_idx += 1
      pattern.slide
    end
    count
  end

  def count_pattern(pattern, start_idx)
    counter = 0
    count = 0
    current = SubstringCounter.new(self[0..-1], pattern.len, start_idx + 1)

    loop do
      count += 1 if pattern.is_anagram_of?(current)
      break unless current.can_slide?
      current.slide

      counter += 1
      if counter > 1000
        puts 'inner infinite loop'
        break
      end

    end
    count
  end

end



class SubstringCounter < String
  attr_accessor :len, :count_arr
  def initialize(string, len, start = 0)
    super(string)
    @count_arr = Array.new(256) { 0 }
    @len = len
    reset_to_index(start)
  end

  def reset_to_index(idx)
    @count_arr.map! { |elem| 0 }
    @first = idx
    @next = idx
    @len.times do
      add_element
    end
  end

  def can_slide?
    @next < self.length
  end


  def add_element
    if can_slide?
      @count_arr[self[@next].ord] += 1
      @next += 1
    end
  end

  def remove_element
    @count_arr[self[@first].ord] -= 1
    @first += 1
  end

  def slide
    add_element
    remove_element
  end

  def is_anagram_of?(other)
    self.count_arr == other.count_arr
  end
end
