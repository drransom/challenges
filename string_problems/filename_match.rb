require 'byebug'

class FileMatcher

  def match(pattern, filenames)
    filenames.select { |filename| pattern_match?(pattern, filename)}
  end

  def pattern_match?(pattern, filename, options = {})
    pattern_index = options[:pattern_index] || 0
    file_index = options[:file_index] || 0
    return true if pattern[pattern_index..-1] == filename[file_index..-1]
    pattern_index.upto(pattern.length-1) do |idx|
      return false if file_index > filename.length
      case pattern[idx]
      when '?'
        return match_with_wildcard?(pattern, filename, idx, file_index)
      when '*'
        return match_with_all_wildcard?(pattern, filename, idx, file_index)
      else
        return false unless pattern[idx] == filename[file_index]
        file_index += 1
      end
    end
    file_index == filename.length
  end

  def match_with_wildcard?(pattern, filename, pattern_index, file_index)
    new_idx = pattern_index + 1
    pattern_match?(pattern, filename, {pattern_index: new_idx, file_index: file_index}) ||
    pattern_match?(pattern, filename, {pattern_index: new_idx, file_index: file_index + 1})
  end

  def match_with_all_wildcard?(pattern, filename, pattern_index, file_index)
    file_index.upto(filename.length) do |idx|
      return true if pattern_match?(pattern, filename, {pattern_index: pattern_index + 1, file_index: idx})
    end
    false
  end
end
