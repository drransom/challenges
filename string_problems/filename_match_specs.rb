require 'rspec'
require_relative 'filename_match'

context FileMatcher do
  describe '#pattern_match?' do
    subject(:filenames) { FileMatcher.new }

    it 'matches a string to itself' do
      pattern = 'abcde'
      expect(filenames.pattern_match?(pattern, pattern)).to be_truthy
    end

    it 'does not match an unequal string' do
      pattern1 = 'abcde'
      pattern2 = '12345'
      expect(filenames.pattern_match?(pattern1, pattern2)).to be_falsy
    end
  end
end
