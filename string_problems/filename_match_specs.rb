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
      pattern = 'abcde'
      string = '12345'
      expect(filenames.pattern_match?(pattern, string)).to be_falsy
    end

    it 'matches a string with a one-character wildcard' do
      pattern = 'ab?de'
      string = 'abcde'
      expect(filenames.pattern_match?(pattern, string)).to be_truthy
    end

    it 'wildcard can be no characters' do
      pattern = 'ab?de'
      string = 'abde'
      expect(filenames.pattern_match?(pattern, string)).to be_truthy
    end

    it 'one-character wildcard at start' do
      pattern = '?bcde'
      string = 'abcde'
      expect(filenames.pattern_match?(pattern, string)).to be_truthy
    end

    it 'zero-character wildcard at start' do
      pattern = '?bcde'
      string = 'bcde'
      expect(filenames.pattern_match?(pattern, string)).to be_truthy
    end

    it 'one-character wildcard at end' do
      pattern = 'abcd?'
      string = 'abcde'
      expect(filenames.pattern_match?(pattern, string)).to be_truthy
    end

    it 'zero-character wildcard at end' do
      pattern = 'abcd?'
      string = 'abcd'
      expect(filenames.pattern_match?(pattern, string)).to be_truthy
    end

    it 'question mark in string is not wild' do
      pattern = 'abcde'
      string = 'ab?de'
      expect(filenames.pattern_match?(pattern, string)).to be_falsy
    end

    it 'question mark matches an empty string' do
      pattern = '?'
      string = ''
      expect(filenames.pattern_match?(pattern, string)).to be_truthy
    end

    it 'multiple question marks in a row' do
      pattern = 'ab??e'
      string = 'abe'
      expect(filenames.pattern_match?(pattern, string)).to be_truthy
    end

    it 'multiple opening question marks' do
      pattern = '??bcde'
      string = 'abcde'
      expect(filenames.pattern_match?(pattern, string)).to be_truthy
    end

    it 'has question mark but does not match' do
      pattern = 'ab?de'
      string = 'abcee'
      expect(filenames.pattern_match?(pattern, string)).to be_falsy
    end


  end
end
