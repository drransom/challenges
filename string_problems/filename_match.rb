class FileMatcher

  def match(pattern, filenames)
    filenames.select { |filename| pattern_match?(pattern, filename)}
  end

  def pattern_match?(pattern, filename)
    # filename == pattern
  end
end
