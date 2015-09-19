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
