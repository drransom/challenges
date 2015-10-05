require 'rspec'
require_relative 'merge_k'

describe '#merge_k_lists' do
  it 'returns nil when nothing is passed' do
    expect(merge_k_lists).to eq(nil)
  end

  it 'one list' do
    node1 = DLLNode.new(5)
    node2 = DLLNode.new(10)
    node3 = DLLNode.new(15)
    node1.child = node2
    node2.child = node3
    expect(merge_k_lists([node1]).value).to eq(5)
    expect(node1.child).to be(node2)
    expect(node2.child).to be(node3)
    expect(node3.child).to eq(nil)
  end

  it 'three lists' do
    node1a = DLLNode.new(5)
    node1b = DLLNode.new(10)
    node1c = DLLNode.new(15)
    node1a.child = node1b
    node1b.child = node1c
    node2a = DLLNode.new(-1)
    node2b = DLLNode.new(0)
    node2a.child = node2b
    node2c = DLLNode.new(45)
    node2b.child = node2c
    node3a = DLLNode.new(8)
    expect(merge_k_lists([node1a, node2a, node3a]).value).to eq(-1)
    expect(node2a.child).to be(node2b)
    expect(node2b.child).to be(node1a)
    expect(node1a.child).to be(node3a)
    expect(node3a.child).to be(node1b)
    expect(node1b.child).to be(node1c)
    expect(node1c.child).to be(node2c)
    expect(node2c.child).to eq(nil)
  end
end
