require 'rspec'
require_relative 'maximum_path_sum'

describe '#max_path_sum' do
  it 'nil entry' do
    expect(max_path_sum).to eq(0)
  end

  it 'no children' do
    node = TreeNode.new(-5)
    expect(max_path_sum(node)).to eq(-5)
  end

  it 'one child' do
    node = TreeNode.new(5)
    node.left = TreeNode.new(2)
    expect(max_path_sum(node)).to eq(7)
  end
end
