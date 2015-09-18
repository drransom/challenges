require 'byebug'

class FileMatcher

  def match(filenames, pattern)
    filenames.select { |filename| pattern_match?(filename, pattern) }
  end

  def pattern_match?(filename, pattern)
    check_pattern_match?(FilenameMatchData.new(filename, pattern))
  end

  def check_pattern_match?(matchData, options = {})
    pattern_idx = options[:pattern_idx] || 0
    file_idx = options[:file_idx] || 0
    pattern = matchData.pattern
    filename = matchData.filename
    return true if matchData.match_remaining?(file_idx, pattern_idx)
    pattern_idx.upto(pattern.length-1) do |idx|
      return false if file_idx > filename.length
      case pattern[idx]
      when '?'
        return match_with_wildcard?(matchData, idx, file_idx)
      when '*'
        return match_all_with_wildcard?(matchData, idx, file_idx)
      else
        return false unless matchData.match?(file_idx, idx)
        file_idx += 1
      end
    end
    file_idx == filename.length
  end

  def match_with_wildcard?(matchData, pattern_idx, file_idx)
    new_idx = pattern_idx + 1
    match_all_with_wildcard?(matchData, pattern_idx, file_idx, file_idx + 1)
  end

  def match_all_with_wildcard?(matchData, pattern_idx, file_idx, max = nil)
    file_idx.upto(max || matchData.filename.length) do |idx|
      return true if check_pattern_match?(matchData, {pattern_idx: pattern_idx + 1, file_idx: idx})
    end
    false
  end

  class FilenameMatchData
    attr_reader :filename, :pattern
    def initialize(filename, pattern)
      @filename = filename
      @pattern = pattern
    end

    def match?(file_idx, pattern_idx)
      @filename[file_idx] == @pattern[pattern_idx]
    end

    def match_remaining?(file_idx, pattern_idx)
      @filename[file_idx..-1] == @pattern[pattern_idx..-1]
    end
  end
end
