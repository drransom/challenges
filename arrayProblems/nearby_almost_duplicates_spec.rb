require 'rspec'
require_relative 'nearby_almost_duplicates'

describe '#contains_nearby_almost_duplicate' do
  it 'empty nums' do
    expect(contains_nearby_almost_duplicate([], 3, 5)).to eq(false)
  end

  it 'one element' do
    expect(contains_nearby_almost_duplicate([1], 1, 1)).to eq(false)
  end

  it 'simple equality' do
    expect(contains_nearby_almost_duplicate([1, 10, 6, 1, 14], 3, 0)).to eq(true)
  end

  it 'numbers different' do
    expect(contains_nearby_almost_duplicate([1, 10, 6, 3, 14], 3, 2)).to eq(true)
  end

  it 'nearly equal numbers not within range' do
    expect(contains_nearby_almost_duplicate([1, 10, 6, 3, 14], 2, 2)).to eq(false)
  end

  it 'passing numbers in middle of queue' do
    array = [-5, 10, -30, 50, 26, 100, 200, 24, -500]
    expect(contains_nearby_almost_duplicate(array, 3, 3)).to eq(true)
  end

  it 'different test case' do
    array = [1,3,6,2]
    expect(contains_nearby_almost_duplicate(array, 1, 2)).to eq(true)
  end

end
