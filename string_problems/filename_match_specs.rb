require 'rspec'
require_relative 'filename_match'

context FileMatcher do
  describe '#pattern_match?' do
    subject(:filenames) { FileMatcher.new }

    it 'matches a string to itself' do
      pattern = 'abcde'
      filenames.set_pattern('abcde')
      expect(filenames.pattern_match?(pattern)).to be_truthy
    end
  end
end
