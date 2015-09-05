require 'rspec'
require_relative 'n_dimensional_array'

def create_array
  array = [].tap do |arr|
    3.times do
      arr << []
    end
  end.each_with_index do |row, idx|
    3.times do |i|
      row << [].tap do |arr|
        3.times do |j|
          arr << (idx + i) * (j + 1)
        end
      end
    end
  end
  array
end


context NDArray do
  describe '#initialize' do
    it 'initializes with an empty array if no array given' do
      x = NDArray.new()
      expect(x.array).to eq([])
    end
    it 'takes an array' do
      x = NDArray.new([1])
      expect(x.array).to eq([1])
    end

    it 'takes an n-dimensional array' do
      x = NDArray.new([[1, 2], [3, 4]])
      expect(x.array).to eq([[1, 2,], [3, 4]])
    end
  end

  describe '#[]' do
    subject(:nd_arr) { NDArray.new(create_array) }

    it 'can index into a column' do
      expect(nd_arr[0]).to eq([[0, 0, 0], [1, 2, 3], [2, 4, 6]])
      expect(nd_arr[1]).to eq([[1, 2, 3], [2, 4, 6], [3, 6, 9]])
      expect(nd_arr[2]).to eq([[2, 4, 6], [3, 6, 9], [4, 8, 12]])
    end

    it 'returns nil if index out of bounds' do
      expect(nd_arr[3]).to eq(nil)
    end

    it 'index two levels deep' do
      expect(nd_arr[1, 1]).to eq([2, 4, 6])
    end

    it 'first index out of bounds' do
      expect(nd_arr[3, 1]).to eq(nil)
    end

    it 'index three levels deep' do
      expect(nd_arr[1, 2, 1]).to eq(6)
      expect(nd_arr[2, 1, 2]).to eq(9)
    end
  end
end
