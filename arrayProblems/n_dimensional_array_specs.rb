require 'rspec'
require_relative 'n_dimensional_array'

describe NDArray do
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
    subject(:nd_array) { NDArray.new [[1, 2], [3, 4]]}
    it 'is true' do
      expect(true).to eq(true)
    end
  end
end
