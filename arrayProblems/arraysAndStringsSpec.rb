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

describe Array do
  context '#rotate_90_degrees!' do
    it 'handles an empty array' do
      arr = []
      arr.rotate_90_degrees!
      expect(arr).to be_empty
    end

    it 'handles a 1x1 case' do
      arr = [[1]]
      arr.rotate_90_degrees!
      expect(arr).to eq([[1]])
    end

    it 'handles a 2x2 case' do
      arr = [[1, 2], [3, 4]]
      arr.rotate_90_degrees!
      expect(arr).to eq([[4, 1], [3, 2]])
    end

    it 'handles a 3x3 case' do
      arr = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
      arr.rotate_90_degrees!
      expect(arr).to eq([7, 4, 1], [8, 5, 2], [9, 6, 3])
    end
  end
end
