require 'rspec'
require_relative 'shortest_palindrome'

describe '#shortest_palindrome' do
  it 'empty string' do
    expect(shortest_palindrome('')).to eq('')
  end

  it 'one character string' do
    expect(shortest_palindrome('a')).to eq('a')
  end

  it 'three character palindrome' do
    expect(shortest_palindrome('aba')).to eq('aba')
  end

  it 'not already a palindrome' do
    expect(shortest_palindrome('ba')).to eq('aba')
  end

end

context String do
  describe '#kmp_search' do
    it 'empty string' do
      expect(''.kmp_search('a')).to be_falsy
    end

    it 'simple case' do
      expect('abc'.kmp_search('bc')).to eq(1)
    end

    it 'string appears multiple times' do
      expect('abcdbcd'.kmp_search('bcd')).to eq(1)
    end

    it 'search for empty string' do
      expect('abc'.kmp_search('')).to eq(0)
    end

    it 'searched string equals entire string' do
      expect('abcdefg'.kmp_search('abcdefg')).to eq(0)
    end

    it 'searched string is not present' do
      expect('abcdefg'.kmp_search('abdeg')).to be_falsy
    end
  end
end
