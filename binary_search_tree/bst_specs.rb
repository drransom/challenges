require 'rspec'
require_relative 'binary_search_tree.rb'

describe SelfBalancingBinarySearchTree do
  context 'inserting nodes' do
    subject(:tree) { SelfBalancingBinarySearchTree.new }

    describe '#add_element' do
      it 'has an add element method' do
        expect(tree).to respond_to(:add_element)
      end

      it 'returns the node added' do
        new_node = tree.add_element(5)
        expect(new_node).to be_a(BSTNode)
        expect(new_node.value).to eq(5)
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

    describe '#include?' do

      it 'can find an included element' do
        letters = ('a'..'k').to_a
        values = (0..10).to_a.zip(letters)
        (0..10).to_a.zip('a'..'k').shuffle.to_h.each do |value, data|
          tree.add_element(value, data)
        end
        11.times do |i|
          expect(tree.include?(i)).to be_truthy
        end
      end

      it 'does not find an element that is not included' do
        letters = ('a'..'f').to_a
        (0..5).to_a.shuffle.each do |num|
          tree.add_element(num, letters[num])
        end
        expect(tree.include?(6)).to be_falsy
      end

    end
  end

  context 'enumeration' do
    subject(:tree) { SelfBalancingBinarySearchTree.new}

    before(:each) do
      letters = ('a'..'k').to_a
      values = (0..10).to_a
      letters.zip(values).shuffle.to_h.each do |value, data|
        tree.add_element(value, data)
      end
    end

    describe '#to_a' do
      it 'empty list' do
        expect(SelfBalancingBinarySearchTree.new.to_a).to be_empty
      end

      it 'puts elements in the array in the correct order' do
        letters = ('a'..'k').to_a
        tree.to_a.each_with_index do |node, idx|
          expect(node.value).to eq(letters[idx])
          expect(node.data).to eq(idx)
        end
      end
    end

    describe '#each' do
      it 'returns an enumerator if no block given' do
        expect(tree.each).to be_a(Enumerator)
      end

      it 'can map over each' do
        concat = ''
        sum = 0
        tree.each do |value, data|
          concat += value
          sum += data
        end
        expect(concat).to eq('abcdefghijk')
        expect(sum).to eq(55)
      end
    end
  end

  context 'rebalancing' do
    subject(:tree) { SelfBalancingBinarySearchTree.new }

    describe '#add_element' do
      it 'simple right side case' do
        expected_left = tree.add_element(0, 'a')
        expected_root = tree.add_element(1, 'b')
        expected_right = tree.add_element(2, 'c')
        expect(tree.root.height).to eq(1)
        expect(tree.root.value).to eq(expected_root.value)
        expect(tree.root.data).to eq(expected_root.data)
        expect(tree.root.left_child.value).to eq(expected_left.value)
        expect(tree.root.left_child.data).to eq(expected_left.data)
        expect(tree.root.right_child.value).to eq(expected_right.value)
        expect(tree.root.right_child.data).to eq(expected_right.data)
      end

      it 'simple left side case' do
        expected_right = tree.add_element(0, 'a')
        expected_root = tree.add_element(-1, 'b')
        expected_left = tree.add_element(-2, 'c')
        expect(tree.root.height).to eq(1)
        expect(tree.root.value).to eq(expected_root.value)
        expect(tree.root.data).to eq(expected_root.data)
        expect(tree.root.left_child.value).to eq(expected_left.value)
        expect(tree.root.left_child.data).to eq(expected_left.data)
        expect(tree.root.right_child.value).to eq(expected_right.value)
        expect(tree.root.right_child.data).to eq(expected_right.data)
      end


    end
  end

end
