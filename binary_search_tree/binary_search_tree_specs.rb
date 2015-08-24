require 'rspec'
require_relative 'binary_search_tree.rb'

describe SelfBalancingBinarySearchTree do
end

describe BSTNode do
  context 'initialization' do
    let(:left) { double("BSTNode") }
    let(:right) { double("BSTNode") }
    let(:parent) { double("BSTNode") }
    describe '#initialize' do
      it 'can take left, right, and parent' do
        options = { left_child: left, right_child: right, parent: parent, value: 5}
        test_node = BSTNode.new(options)
        expect(test_node.left_child).to eq(left)
        expect(test_node.right_child).to eq(right)
        expect(test_node.parent).to eq(parent)
        expect(test_node.value).to eq(5)
      end

      it 'can accept only some options' do
        options = { left_child: left, parent: parent }
        test_node = BSTNode.new(options)
        expect(test_node.left_child).to eq(left)
        expect(test_node.right_child).to eq(nil)
        expect(test_node.value).to eq(nil)
        expect(test_node.parent).to eq(parent)
      end

      it 'requires no options' do
        expect {BSTNode.new}.to_not raise_error
      end
    end
  end

  context 'setting other nodes' do
    let(:other_node) { double("BSTNode") }
    let(:other_node_2) { double("BSTNode") }
    subject(:test_node) { BSTNode.new }

    describe '#set_left_child' do
      it 'sets the child' do
        test_node.set_left_child(other_node)
        expect(test_node.left_child).to be(other_node)
      end

      it 'overwrites a previously written child' do
        test_node.set_left_child(other_node_2)
        expect(test_node.left_child).to be(other_node_2)
        test_node.set_left_child(other_node)
        expect(test_node.left_child).to be(other_node)
      end

      it 'returns the original node' do
        expect(test_node.set_left_child(other_node)).to be(test_node)
      end
    end

    describe '#set_right_child' do
      it 'sets the child' do
        test_node.set_right_child(other_node)
        expect(test_node.right_child).to be(other_node)
      end

      it 'overwrites a previously written child' do
        test_node.set_right_child(other_node_2)
        expect(test_node.right_child).to be(other_node_2)
        test_node.set_right_child(other_node)
        expect(test_node.right_child).to be(other_node)
      end

      it 'returns the original node' do
        expect(test_node.set_right_child(other_node)).to be(test_node)
      end
    end

    describe '#set_parent' do
      it 'sets the parent' do
        test_node.set_parent(other_node)
        expect(test_node.parent).to be(other_node)
      end

      it 'overwrites a previously written child' do
        test_node.set_parent(other_node_2)
        expect(test_node.parent).to be(other_node_2)
        test_node.set_parent(other_node)
        expect(test_node.parent).to be(other_node)
      end

      it 'returns the original node' do
        expect(test_node.set_parent(other_node)).to be(test_node)
      end
    end
  end

  context 'setting value' do
    subject(:test_node) { BSTNode.new( value: 5 ) }

    describe '#set_value' do
      it 'sets the value' do
        test_node.set_value(10)
        expect(test_node.value).to eq(10)
      end

      it 'can set the value multiple times' do
        test_node.set_value(10)
        expect(test_node.value).to eq(10)
        test_node.set_value(0)
        expect(test_node.value).to eq(0)
      end

      it 'returns the node' do
        expect(test_node.set_value(10)).to be(test_node)
      end
    end
  end
end