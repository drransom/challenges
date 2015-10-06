require 'rspec'
require_relative 'sum_root_to_leaf'

describe '#sum_numbers' do
  it 'no argument' do
    expect(sum_numbers).to eq(0)
  end

  it 'one root' do
    node = TreeNode.new(5)
    expect(sum_numbers(node)).to eq(5)
  end

  it 'one leaf' do
    node = TreeNode.new(5)
    node2 = TreeNode.new(8)
    node.left = node2
    expect(sum_numbers(node)).to eq(58)
  end

  it 'two leaves' do
    node = TreeNode.new(5)
    node2 = TreeNode.new(8)
    node3 = TreeNode.new(4)
    node.left = node2
    node.right = node3
    expect(sum_numbers(node)).to eq(112)
  end

  it 'more complicated case including zeroes' do
    node = TreeNode.new(5)
    node2 = TreeNode.new(0)
    node3 = TreeNode.new(4)
    node.left = node2
    node.right = node3
    node4 = TreeNode.new(1)
    node5 = TreeNode.new(6)
    node2.left = node4
    node2.right = node5
    node3.left = TreeNode.new(0)
    expect(sum_numbers(node)).to eq(1547)
  end
end
