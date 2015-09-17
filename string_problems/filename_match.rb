class FileMatcher
  def initialize
    @pattern = ''
  end

  def set_pattern(pattern)
    @pattern = pattern
  end

  def match(filenames)
    filenames.select { |filename| pattern_match?(filename)}
  end

  def pattern_match?(filename)
    # filename == @pattern
  end
end
