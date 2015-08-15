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

  context '#basic_compression' do
    it 'handles a simple case' do
      expect('aaaaa'.basic_compression).to eq('a5')
    end
    it 'handles a more complicated case' do
      expect('baaaccbbbbba'.basic_compression).to eq('b1a3c2b5a1')
    end

    it 'empty string' do
      expect(''.basic_compression).to eq('')
    end

    it 'compressed is longer than original' do
      expect('ababaa'.basic_compression).to eq('ababaa')
    end
  end
end

describe Array do
  context '#zeroify!' do
    it 'handles a 1x1 case' do
      test_array = [[0]]
      test_array.zeroify!
      expect(test_array).to eq([[0]])
    end

    it 'zero rows and columns' do
      test_array = []
      test_array.zeroify!
      expect(test_array).to be_empty
    end

    it 'more complicated case' do
      test_array = [[1, 2, 3],
                    [4, 5, 0],
                    [7, 0, 9],
                    [1, 5, 2]]
      correct_answer = [[1, 0, 0],
                        [0, 0, 0],
                        [0, 0, 0],
                        [1, 0, 0]]
      test_array.zeroify!
      expect(test_array).to eq(correct_answer)
    end

    it 'returns the original array' do
      test_array = [[5]]
      expect(test_array.zeroify!).to be(test_array)
    end
  end
  # context '#rotate_90_degrees!' do
  #   it 'handles an empty array' do
  #     arr = []
  #     arr.rotate_90_degrees!
  #     expect(arr).to be_empty
  #   end
  #
  #   it 'handles a 1x1 case' do
  #     arr = [[1]]
  #     arr.rotate_90_degrees!
  #     expect(arr).to eq([[1]])
  #   end
  #
  #   it 'handles a 2x2 case' do
  #     arr = [[1, 2], [3, 4]]
  #     arr.rotate_90_degrees!
  #     expect(arr).to eq([[3, 1], [4, 2]])
  #   end
  #
  #   it 'handles a 3x3 case' do
  #     arr = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  #     arr.rotate_90_degrees!
  #     expect(arr).to eq([[7, 4, 1], [8, 5, 2], [9, 6, 3]])
  #   end
  # end
end
