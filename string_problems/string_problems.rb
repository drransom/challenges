require 'byebug'

class String
  def longest_palindromic_substring
    longest_palindromic_substring_n_squared
  end

  def longest_palindromic_substring_n_squared
    return '' if self.empty?

    best_low = best_high =  0
    best_length = Proc.new { best_high - best_low + 1 }

    length.times do |center_index|
      current_low = center_index
      odd_high = center_index
      even_high = center_index + 1
      check_even = true
      check_odd = true

      while (check_even || check_odd) && current_low >= 0 && odd_high < length
        if self[current_low] != self[odd_high]
          check_odd = false
        end
        if self[current_low] != self[even_high] || even_high >= length
          check_even = false
        end
        if check_odd && odd_high - current_low + 1 > best_length.call
          best_low, best_high = current_low, odd_high
        end
        if check_even && even_high - current_low + 1 > best_length.call
          best_low, best_high = current_low, even_high
        end

        current_low -= 1
        odd_high += 1
        even_high += 1
      end

      break if best_length.call >= length - center_index

    end
    self[best_low..best_high]
  end
  
end
