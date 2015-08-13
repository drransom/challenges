class String

  def pig_latinize
    self.split(' ').map do |word|
      pig_latinize_one_word(word)
    end.join(' ')
  end

  def opening_vowel
    /\A[aeiouy]/i
  end

  def opening_capital
    /\A[A-Z]/
  end

  def multiple_consonants
    /\A[^aeiouy]*/i
  end

  def allcaps
    allcaps = /\A[A-Z]*\z/
  end

  def pig_latinize_one_word(word)

    if word.match(opening_vowel)
      new_string = word + 'yay'
    else
      opening_consonants = word.match(multiple_consonants).to_s
      rest_of_string = word[(opening_consonants.length)..-1]
      new_string = rest_of_string + opening_consonants + 'ay'
    end
    adjust_capitalization!(word, new_string)
    new_string
  end


  def adjust_capitalization!(original_word, new_string)
    if original_word.match(allcaps)
      new_string.upcase!
    elsif original_word.match(opening_capital)
      new_string.downcase!
      new_string.capitalize!
    end
  end


end
