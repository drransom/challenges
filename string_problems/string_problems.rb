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
























  # def longest_palindromic_substring_n_squared_old
  #   return self if empty?
  #   best_high = 0
  #   best_low = 0
  #   best_length = 1
  #   self.length.times do |center_idx|
  #     current_odd_high = current_low = center_idx
  #     current_even_high = center_idx + 1
  #     continue_odd = true
  #     continue_even = true
  #     while current_low >= 0 && current_odd_high < length &&
  #           (continue_odd || continue_even)
  #       if continue_odd && self[current_low] != self[current_odd_high]
  #         continue_odd = false
  #       end
  #       if continue_even && current_even_high < length && self[current_even_high] != self[current_low]
  #         continue_even = false
  #       end
  #
  #       continue_even = false if current_even_high >= length
  #
  #
  #       if continue_odd && current_odd_high - current_low + 1 > best_length
  #         best_low = current_low
  #         best_high = current_odd_high
  #         best_length = best_high - best_low + 1
  #       elsif continue_even && current_even_high - current_low + 1 > best_length
  #         best_low = current_low
  #         best_high = current_even_high
  #         best_length = best_high - best_low + 1
  #       end
  #
  #       current_low -= 1
  #       current_even_high += 1
  #       current_odd_high += 1
  #     end
  #
  #   end
  #
  #   self[best_low..best_high]
  #
  #
  #
  # end
end
