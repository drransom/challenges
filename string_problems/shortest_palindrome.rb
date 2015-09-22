def shortest_palindrome(string)
  reversed = string.reverse
  kmp =

end

class String

  def kmp_search(target)
    return 0 if target == '' && !empty?
    kmp_table = construct_kmp_table(target)
    run_kmp_search(target, kmp_table)
  end

  def construct_kmp_table(target)
    idx = cnd = 0
    Array.new([target.length, 2].max).tap do |kmp_table|
      while idx < ([target.length, 2].max) do
        idx, cnd = add_to_kmp_table(kmp_table, target, idx, cnd)
      end
    end
  end

  private


  def add_to_kmp_table(kmp_table, target, idx, cnd)
    if idx <= 1
      kmp_table[idx] = idx - 1
      idx += 1
    elsif target[idx-1] == target[cnd]
      cnd += 1
      kmp_table[idx] = cnd
      idx += 1
    elsif cnd > 0
      cnd = kmp_table[cnd]
    else
      kmp_table[idx] = 0
      idx += 1
    end
    [idx, cnd]
  end



  def run_kmp_search(target, kmp_table)
    s_idx = 0 #current position in self
    t_idx = 0 #current position in target
    while s_idx + t_idx < length
      if target[t_idx] == self[s_idx + t_idx]
        return s_idx if t_idx == target.length - 1
        t_idx += 1
      elsif kmp_table[t_idx]
        s_idx += t_idx - kmp_table[t_idx]
      else
        s_idx += 1
        t_idx = 0
      end
    end
    nil
  end
end
