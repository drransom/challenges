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

  it 'two children' do
    node = TreeNode.new(5)
    node.left = TreeNode.new(3)
    node.right = TreeNode.new(2)
    expect(max_path_sum(node)).to eq(10)
  end

  it 'best path is left child' do
    node = TreeNode.new(-10)
    node.left = TreeNode.new(5)
    node.right = TreeNode.new(0)
    expect(max_path_sum(node)).to eq(5)
  end

  it 'best path goes through negative root' do
    node = TreeNode.new(-10)
    node.left = TreeNode.new(20)
    node.right = TreeNode.new(20)
    expect(max_path_sum(node)).to eq(30)
  end

  it 'more complicated case' do
    node = TreeNode.new(5)
    node.left = TreeNode.new(10)
    node.left.left = TreeNode.new(20)
    node.left.right = TreeNode.new(10)
    node.right = TreeNode.new(5)
    expect(max_path_sum(node)).to eq(40)
  end
end
