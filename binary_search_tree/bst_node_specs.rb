require 'rspec'
require_relative 'binary_search_tree.rb'

describe BSTNode do

  context 'initialization' do
    let(:left_child) { double(" BSTNode") }
    # left_child.stub(depth: 0)
    let(:right_child) { double("BSTNode") }
    # right_child.stub(depth: 0)
    let(:parent) { double("BSTNode") }
    # parent.stub(depth: 0)

    describe '#initialize' do
      before(:example) do
        allow(left_child).to receive(:depth).and_return(0)
        allow(right_child).to receive(:depth).and_return(0)
        allow(parent).to receive(:depth).and_return(0)
      end


      it 'can take left, right, and parent' do
        options = { left_child: left_child, right_child: right_child, parent: parent, value: 5}
        test_node = BSTNode.new(options)
        expect(test_node.left_child).to eq(left_child)
        expect(test_node.right_child).to eq(right_child)
        expect(test_node.parent).to eq(parent)
        expect(test_node.value).to eq(5)
      end

      it 'can accept only some options' do
        options = { left_child: left_child, parent: parent }
        test_node = BSTNode.new(options)
        expect(test_node.left_child).to eq(left_child)
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
    before(:example) do
      allow(other_node).to receive(:depth).and_return(0)
      allow(other_node_2).to receive(:depth).and_return(0)
    end

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

  context 'depth and balance' do
  end
end
