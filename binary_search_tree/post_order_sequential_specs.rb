require 'rspec'
require_relative 'post_order_sequential'

context BinarySearchTree do

  describe '#post_order_sequential' do
    it 'empty tree' do
      tree = BinarySearchTree.new
      expect(tree.post_order_sequential).to be_empty
    end

    it 'tree with one element' do
      tree = BinarySearchTree.new([1])
      expect(tree.post_order_sequential).to eq([1])
    end

    it 'elements on right side' do
      tree = BinarySearchTree.new([1, 2, 3])
      expect(tree.post_order_sequential).to eq([3, 2, 1])
    end

    it 'complicated case' do
      tree = BinarySearchTree.new([0, -4, -8, -2, -3, -1, 4, 8, 6])
      expect(tree.post_order_sequential).to eq([-8, -3, -1, -2, -4, 6, 8, 4, 0])
    end

  end
end
