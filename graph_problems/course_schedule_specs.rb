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
    expect(can_finish(2, [[1, 2]])).to eq(true)
  end

  it 'impossible case' do
    expect(can_finish(2, [[1, 2], [2, 1]])).to eq(false)
  end

  it 'cycle' do
    expect(can_finish(3, [[1, 2], [2, 3], [3, 1]])).to eq(false)
  end
end
