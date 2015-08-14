class String
  def is_permutation?(other_string)
    return false unless self.length == other_string.length
    this_count = count_chars(self)
    this_count == count_chars(other_string)
  end

  def replace_spaces
    self.gsub(' ', '%20')
  end

private

  def count_chars(str)
    output = Hash.new(0)
    str.each_char do |char|
      output[char] += 1
    end
    output
  end



end
