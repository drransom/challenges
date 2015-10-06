require 'rspec'
require_relative 'maximum_path_sum'

describe '#max_path_sum' do
  it 'nil entry' do
    expect(max_path_sum).to eq(0)
  end
end
