require 'rspec'
require_relative 'string_problems.rb'

context String do
  describe '#longest_palindromic_substring' do
    it 'empty string' do
      expect(''.longest_palindromic_substring).to eq('')
    end

    it 'one character' do
      expect('a'.longest_palindromic_substring).to eq('a')
    end


    it 'finds first character if there are no palindromes' do
      expect('abcae'.longest_palindromic_substring).to eq('a')
    end

    it 'finds an even palindrome' do
      expect('abace'.longest_palindromic_substring).to eq('aba')
    end

    it 'finds an odd palindrome' do
      expect('fabba'.longest_palindromic_substring).to eq('abba')
    end

    it 'at end of word' do
      expect('abdefed'.longest_palindromic_substring).to eq('defed')
    end

    it 'within middle of word' do
      expect('dabcbcbef'.longest_palindromic_substring).to eq('bcbcb')
    end

    it 'mixed character types' do
      expect('a % D 3 D % fx6ns'.longest_palindromic_substring).to eq(' % D 3 D % ')
    end

    it 'non-overlapping palindromes' do
      expect('abebxjijij'.longest_palindromic_substring).to eq('jijij')
    end
  end
end
