class String

  def pig_latinize
    self.split(' ').map do |word|
      pig_latinize_one_word(word)
    end.join(' ')
  end

  def pig_latinize_one_word(word)
    opening_vowel = /\A[aeiouy]/i
    opening_capital = /\A[A-Z]/
    multiple_consonants = /\A[^aeiouy]*/i
    if word.match(opening_vowel)
      word + 'yay'
    else
      opening_consonants = word.match(multiple_consonants).to_s
      rest_of_string = word[(opening_consonants.length)..-1]
      new_string = rest_of_string + opening_consonants + 'ay'
      word.match(opening_capital) ? new_string.downcase.capitalize : new_string
    end
  end
end
