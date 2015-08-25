require 'rspec'
require_relative 'binary_search_tree.rb'

class MockBSTNode
  def height
    0
  end

  def balance
    0
  end
end

describe BSTNode do

  context 'initialization' do
    let(:left_child) { MockBSTNode.new }
    let(:right_child) { MockBSTNode.new }
    let(:parent) { MockBSTNode.new }

    describe '#initialize' do

      it 'can take a value' do
        test_node = BSTNode.new(5)
        expect(test_node.value).to eq(5)
      end

      it 'does not require a value' do
        expect { BSTNode.new }.to_not raise_error
      end
    end
  end

  context 'setting other nodes' do
    let(:other_node) { MockBSTNode.new }
    let(:other_node_2) { MockBSTNode.new }

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

  context 'updating height and balance' do
    subject(:node) { BSTNode.new }
    let(:other_node) { double("BSTNode") }
    let(:second_other_node) { double( "BSTNode" )}

    describe 'initialization' do
      it 'height is zero when initialized' do
        expect(node.height).to eq(0)
      end
    end

    describe 'updating parent and child' do

      it 'updating the left child' do
        allow(other_node).to receive(:height).and_return(0)
        node.set_left_child(other_node)
        expect(node.height).to eq(1)
        expect(node.balance).to eq(1)
      end

      it 'updating the right child' do
        allow(other_node).to receive(:height).and_return(0)
        node.set_right_child(other_node)
        expect(node.height).to eq(1)
        expect(node.balance).to eq(-1)
      end

      it 'updating both sides' do
        allow(other_node).to receive(:height).and_return(0)
        allow(second_other_node).to receive(:height).and_return(0)
        node.set_left_child(other_node)
        node.set_right_child(second_other_node)
        expect(node.height).to eq(1)
        expect(node.balance).to eq(0)
      end

      it 'updating parent does not change height or balance' do
        expect(other_node).to_not receive(:height)
        node.set_parent(other_node)
        expect(node.height).to eq(0)
        expect(node.balance).to eq(0)
      end

    end

    describe '#balance' do
      it 'is zero when initialized with nothing' do
        test = BSTNode.new
        expect(test.balance).to eq(0)
      end
    end
  end
end
