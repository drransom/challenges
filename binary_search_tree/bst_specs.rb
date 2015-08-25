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

  context 'finding nodes' do
    subject(:tree) { SelfBalancingBinarySearchTree.new }

    describe '#find_data' do

      it 'empty list' do
        expect(tree.find_data(0)).to eq(nil)
      end

      it 'can find the correct data in the list' do
        letters = ('a'..'k').to_a
        values = (0..10).to_a.zip(letters)
        (0..10).to_a.zip('a'..'k').shuffle.to_h.each do |value, data|
          tree.add_element(value, data)
        end
        11.times do |i|
          expect(tree.find_data(i)).to eq(letters[i])
        end
      end

      it 'data are not in the list' do
        letters = ('a'..'f').to_a
        (0..5).to_a.shuffle.each do |num|
          tree.add_element(num, letters[num])
        end
        expect(tree.find_data(6)).to eq(nil)
      end
    end


  end
end
