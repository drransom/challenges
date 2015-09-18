class FileMatcher

  def match(pattern, filenames)
    filenames.select { |filename| pattern_match?(pattern, filename)}
  end

  def pattern_match?(pattern, filename)
    return true if filename == pattern
    file_index = 0
    pattern.length.times do |idx|
      return false if file_index > filename.length
      case pattern[idx]
      when '?'
        return match_with_wildcard?(pattern, filename, idx, file_index)
      else
        return false unless pattern[idx] == filename[file_index]
        file_index += 1
      end
    end
    file_index == filename.length
  end

  def match_with_wildcard?(pattern, filename, pattern_index, file_index)
    pattern_match?(pattern[pattern_index+1..-1], filename[file_index..-1]) ||
    pattern_match?(pattern[pattern_index+1..-1], filename[file_index+1..-1])
  end
end
