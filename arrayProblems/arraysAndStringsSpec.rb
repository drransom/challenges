require 'rspec'
require_relative 'arraysAndStrings.rb'

describe String do
  context '#is_permutation?' do
    it "handles equality" do
      expect("abc".is_permutation?("abc")).to be_truthy
    end

    it "empty string is a permutation of itself" do
      expect("".is_permutation?('')).to be_truthy
    end

    it "empty string is not a permutation of another string" do
      expect(''.is_permutation?("a")).to be_falsy
    end

    it "is permutation" do
      5.times do
        shuffled = [('a'..'f').to_a, ' '].flatten.shuffle.join
        expect("abc def".is_permutation?(shuffled)).to be_truthy
      end
    end

    it "not a permutation" do
      expect("abc".is_permutation?("abf")).to be_falsy
    end
  end

  context '#replace_spaces' do
    it "no spaces" do
      expect("abc".replace_spaces).to eq("abc")
    end

    it "empty string" do
      expect(''.replace_spaces).to eq('')
    end

    it 'one space' do
      expect(' abc'.replace_spaces).to eq('%20abc')
    end

    it 'multiple spaces' do
      expect('a bc e '.replace_spaces).to eq('a%20bc%20e%20')
    end
  end
end
