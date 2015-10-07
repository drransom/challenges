require 'rspec'
require_relative 'course_schedule'

describe '#can_finish' do
  it 'null graph' do
    expect(can_finish(0, [])).to eq(true)
  end

  it 'one element' do
    expect(can_finish(1, [])).to eq(true)
  end

  it 'simple two-element case' do
    expect(can_finish(2, [[0, 1]])).to eq(true)
  end

  it 'impossible case' do
    expect(can_finish(2, [[1, 0], [0, 1]])).to eq(false)
  end

  it 'cycle' do
    expect(can_finish(3, [[1, 2], [2, 0], [0, 1]])).to eq(false)
  end

  it 'cycle in different order' do
    expect(can_finish(3, [[1, 2], [0, 1], [2, 0]])).to eq(false)
  end

  it 'same element' do
    expect(can_finish(1, [[0, 0]])).to eq(false)
  end
end
