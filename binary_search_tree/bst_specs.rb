require 'rspec'
require_relative 'binary_search_tree.rb'

describe SelfBalancingBinarySearchTree do
  context 'inserting nodes' do
    subject(:tree) { SelfBalancingBinarySearchTree.new }

    describe '#add_element' do
      it 'has an add element method' do
        expect(tree).to respond_to(:add_element)
      end

      it 'returns the value added' do
        expect(tree.add_element(5)).to eq(5)
      end

      it 'adds an element to the left' do
        tree.add_element(5)
        tree.add_element(4)
        expect(tree.root.value).to eq(5)
        expect(tree.root.left_child.value).to eq(4)
        expect(tree.root.right_child.value).to eq(nil)
      end

      it 'adds an element to the right' do
        tree.add_element(5)
        tree.add_element(6)
        expect(tree.root.value).to eq(5)
        expect(tree.root.right_child.value).to eq(6)
        expect(tree.root.left_child.value).to eq(nil)
      end

      it 'four elements' do
        tree.add_element(5)
        tree.add_element(10)
        tree.add_element(4)
        tree.add_element(6)
        expect(tree.root.value).to eq(5)
        expect(tree.root.right_child.value).to eq(10)
        expect(tree.root.right_child.left_child.value).to eq(6)
        expect(tree.root.right_child.right_child.value).to eq(nil)
        expect(tree.root.left_child.value).to eq(4)
      end
    end
  end
end
