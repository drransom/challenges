require 'rspec'
require_relative 'binary_search_tree.rb'

describe SBBST do
end

describe BSTNode do
  context 'initialization' do
    let(:left) { double("BSTNode") }
    let(:right) { double("BSTNode") }
    let(:parent) { double("BSTNode") }
    describe '#initialize' do
      it 'can take left, right, and parent' do
        options = { left_child: left, right_child: right, parent: parent }
        test_node = BSTNode.new(options)
        expect test_node.left_child.to eq(left)
        expect test_node.right_child.to eq(right)
        expect test_node.parent.to eq(parent)
      end
    end
  end
end
