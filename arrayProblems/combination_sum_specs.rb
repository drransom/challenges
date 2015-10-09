require 'rspec'
require_relative 'combination_sum'

describe '#combination_sum' do
  it 'no candidates' do
    expect(combination_sum([], 0)).to eq([])
  end

  it 'simple case' do
    expect(combination_sum([1], 1)).to eq([[1]])
  end

  it 'another simple case' do
    answer = [[1, 1, 1, 1], [1, 1, 2], [2, 2]].sort
    expect(combination_sum([1, 2], 4).sort).to eq(answer)
  end

  it 'nothing adds up' do
    expect(combination_sum([2, 4, 6], 9)).to eq([])
  end

  it 'duplicates not produced' do
    answer = [[1, 1], [2]].sort
    expect(combination_sum([1, 1, 1, 2], 2).sort).to eq(answer)
  end
end
