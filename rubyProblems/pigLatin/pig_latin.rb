class String

  def pig_latinize
    opening_vowel = /\A[aeiouy]/i
    opening_capital = /\A[A-Z]/
    multiple_consonants = /\A[^aeiouy]*/i
    if self.match(opening_vowel)
      self + 'yay'
    else
      opening_consonants = self.match(multiple_consonants).to_s
      rest_of_string = self[(opening_consonants.length)..-1]
      new_string = rest_of_string + opening_consonants + 'ay'
      self.match(opening_capital) ? new_string.downcase.capitalize : new_string
    end
  end
end
