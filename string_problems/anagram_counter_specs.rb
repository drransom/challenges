require_relative 'anagram_finder'
require 'rspec'

describe 'String#count_anagramic_substrings' do
  it 'empty string' do
    expect(''.count_anagramic_substrings).to eq(0)
  end

  it 'one character' do
    expect('a'.count_anagramic_substrings).to eq(0)
  end

  it 'two identical characters' do
    expect('zz'.count_anagramic_substrings).to eq(1)
  end

  it 'no anagramic substrings' do
    expect('ab'.count_anagramic_substrings).to eq(0)
  end

  it 'more compex case' do
    expect('abba'.count_anagramic_substrings).to eq(4)
  end

end
