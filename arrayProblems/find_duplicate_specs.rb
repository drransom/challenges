require 'rspec'
require_relative 'find_duplicate'

describe '#find_duplicate' do
  it 'empty array' do
    expect(find_duplicate([])).to eq(0)
  end

  it 'one element' do
    expect(find_duplicate([1])).to eq(1)
  end

  it 'two elements' do
    expect(find_duplicate([1, 1])).to eq(1)
  end

  it 'three elements' do
    expect(find_duplicate([1, 2, 2])).to eq(2)
  end

  it 'highest number duplicate' do
    (3..10).each do |i|
      arr = (1..i).to_a
      arr << i
      expect(find_duplicate(arr)).to eq(i)
    end
  end

  it 'replacing multiple elements with 1' do
    arr = (1..99).to_a
    arr << 1
    9.times { |i| arr[10 * i] = 1 }
    expect(find_duplicate(arr)).to eq(1)
  end

  it 'replacing multiple elements with highest value' do
    arr = (1..99).to_a
    arr << 99
    9.times { |i| arr[10 * i] = 99 }
    expect(find_duplicate(arr)).to eq(99)
  end

  it 'replace high elements with low value' do
    arr = (1..1000).to_a
    arr << 6
    5.times { |i| arr[500 + 40 * i] = 6}
    expect(find_duplicate(arr)).to eq(6)
  end

  it 'replace low values with high value' do
    arr = (1..1000).to_a
    arr << 803
    10.times { |i| arr[i * 40] = 803 }
    expect(find_duplicate(arr)).to eq(803)
  end
end
