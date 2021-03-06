require 'rspec'
require_relative 'binary_search_tree.rb'

def add_at_random(tree)
  letters = ('a'..'k').to_a
  values = (0..10).to_a
  values.zip(letters).shuffle.to_h.each do |value, data|
    tree.add_element(value, data)
  end
end

describe BinarySearchTree do
  context 'inserting and deleting nodes' do
    subject(:tree) { BinarySearchTree.new }

    describe '#add_element' do
      it 'has an add element method' do
        expect(tree).to respond_to(:add_element)
      end

      it 'returns the node added' do
        new_node = tree.add_element(5)
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

    describe '#delete' do
      it 'can delete when there is one element' do
        tree.add_element(5, 3)
        tree.delete(5)
        expect(tree.root).to eq(nil)
      end

      it 'can delete an element on the right' do
        tree.add_element(0)
        tree.add_element(1, 3)
        tree.delete(1)
        expect(tree.root.right_child.value).to eq(nil)
        expect(tree.root.right_child.data).to eq(nil)
      end

      it 'can delete the root with one child' do
        tree.add_element(0)
        tree.add_element(1, 3)
        tree.delete(0)
        expect(tree.root.value).to eq(1)
        expect(tree.root.data).to eq(3)
        expect(tree.root.right_child.value).to eq(nil)
        expect(tree.root.right_child.data).to eq(nil)
      end

      it 'can delete the root with two children' do
        tree.add_element(0)
        tree.add_element(1, 5)
        tree.add_element(-1, 5)
        tree.delete(0)
        expect(tree.root.value.abs).to eq(1)
        expect(tree.root.data).to eq(5)
      end

      it 'can delete an intermediate left node with two children' do
        tree.add_element(0)
        tree.add_element(-2, 0)
        tree.add_element(2)
        tree.add_element(-4, 10)
        tree.add_element(-1, 10)

        tree.delete(-2)
        left_child = tree.root.left_child
        expect(left_child.value == -1 || left_child.value == -4).to eq(true)
        expect(tree.root.left_child.parent.value).to eq(0)
      end

      it 'can delete an intermediate right node with two children' do
        tree.add_element(0)
        tree.add_element(2, 0)
        tree.add_element(-2)
        tree.add_element(4, 10)
        tree.add_element(1, 10)

        tree.delete(2)
        right_child = tree.root.right_child
        expect(right_child.value == 4 || right_child.value == 1).to eq(true)
        expect(right_child.data).to eq(10)
        expect(tree.root.right_child.parent.value).to eq(0)
      end
    end
  end

  context 'finding nodes' do
    subject(:tree) { BinarySearchTree.new }

    describe '#find_data' do

      it 'empty list' do
        expect(tree.find_data(0)).to eq(nil)
      end

      it 'can find the correct data in the list' do
        letters = ('a'..'k').to_a
        10.times do
          tree = BinarySearchTree.new
          add_at_random(tree)
          11.times do |i|
            expect(tree.find_data(i)).to eq(letters[i])
          end
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
        10.times do
          tree = BinarySearchTree.new
          add_at_random(tree)
          11.times do |i|
            expect(tree.include?(i)).to be_truthy
          end
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

    describe '#to_a' do
      it 'empty list' do
        expect(BinarySearchTree.new.to_a).to be_empty
      end

      it 'puts elements in the array in the correct order' do
        letters = ('a'..'k').to_a
        10.times do
          tree = BinarySearchTree.new
          add_at_random(tree)
          tree.to_a.each_with_index do |node, idx|
            expect(node.value).to eq(idx)
            expect(node.data).to eq(letters[idx])
          end
        end
      end
    end

    describe '#each' do
      it 'returns an enumerator if no block given' do
        tree = BinarySearchTree.new
        expect(tree.each).to be_a(Enumerator)
      end

      it 'can map over each' do
        10.times do
          tree = BinarySearchTree.new
          add_at_random(tree)
          concat = ''
          sum = 0
          tree.each do |value, data|
            concat += data
            sum += value
          end
          expect(concat).to eq('abcdefghijk')
          expect(sum).to eq(55)
        end
      end
    end
  end

end

describe SelfBalancingBinarySearchTree do
  context 'inserting and deleting nodes' do
    subject(:tree) { SelfBalancingBinarySearchTree.new }

    describe '#add_element' do
      it 'has an add element method' do
        expect(tree).to respond_to(:add_element)
      end

      it 'returns the node added' do
        new_node = tree.add_element(5)
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

    describe '#delete' do
      it 'can delete when there is one element' do
        tree.add_element(5, 3)
        tree.delete(5)
        expect(tree.root).to eq(nil)
      end

      it 'can delete an element on the right' do
        tree.add_element(0)
        tree.add_element(1, 3)
        tree.delete(1)
        expect(tree.root.right_child.value).to eq(nil)
        expect(tree.root.right_child.data).to eq(nil)
      end

      it 'deleting a node resets the height' do
        tree.add_element(0)
        tree.add_element(1)
        tree.delete(1)
        expect(tree.root.height).to eq(0)
      end

      it 'deleting a node resets the balance' do
        tree.add_element(0)
        tree.add_element(-1)
        tree.delete(-1)
        expect(tree.root.balance).to eq(0)
      end

      it 'can delete the root with one child' do
        tree.add_element(0)
        tree.add_element(1, 3)
        tree.delete(0)
        expect(tree.root.value).to eq(1)
        expect(tree.root.data).to eq(3)
        expect(tree.root.right_child.value).to eq(nil)
        expect(tree.root.right_child.data).to eq(nil)
      end

      it 'can delete the root with two children' do
        tree.add_element(0)
        tree.add_element(1, 5)
        tree.add_element(-1, 5)
        tree.delete(0)
        expect(tree.root.value.abs).to eq(1)
        expect(tree.root.data).to eq(5)
        expect(tree.root.height).to eq(1)
        expect(tree.root.balance.abs).to eq(1)
      end

      it 'can delete an intermediate left node with two children' do
        tree.add_element(0)
        tree.add_element(-2, 0)
        tree.add_element(2)
        tree.add_element(-4, 10)
        tree.add_element(-1, 10)

        tree.delete(-2)
        left_child = tree.root.left_child
        expect(left_child.value == -1 || left_child.value == -4).to eq(true)
        expect(left_child.data).to eq(10)
        expect(tree.root.left_child.parent.value).to eq(0)
        expect(left_child.height).to eq(1)
      end

      it 'can delete an intermediate right node with two children' do
        tree.add_element(0)
        tree.add_element(2, 0)
        tree.add_element(-2)
        tree.add_element(4, 10)
        tree.add_element(1, 10)

        tree.delete(2)
        right_child = tree.root.right_child
        expect(right_child.value == 4 || right_child.value == 1).to eq(true)
        expect(right_child.data).to eq(10)
        expect(tree.root.right_child.parent.value).to eq(0)
        expect(right_child.height).to eq(1)
      end

      it 'imbalanced' do
        tree.add_element(0)
        tree.add_element(2)
        tree.add_element(-4)
        tree.add_element(-2)
        tree.add_element(-6)
        tree.delete(2)
        expect(tree.root.value).to_not eq(0)
        expect(tree.root.right_child.value).to_not eq(2)
        expect(tree.root.right_child.value).to be_truthy
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
        10.times do
          tree = SelfBalancingBinarySearchTree.new
          add_at_random(tree)
          11.times do |i|
            expect(tree.find_data(i)).to eq(letters[i])
          end
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
        10.times do
          tree = SelfBalancingBinarySearchTree.new
          add_at_random(tree)
          11.times do |i|
            expect(tree.include?(i)).to be_truthy
          end
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


    describe '#to_a' do
      it 'empty list' do
        expect(SelfBalancingBinarySearchTree.new.to_a).to be_empty
      end

      it 'puts elements in the array in the correct order' do
        letters = ('a'..'k').to_a
        10.times do
          tree = SelfBalancingBinarySearchTree.new
          add_at_random(tree)
          tree.to_a.each_with_index do |node, idx|
            expect(node.value).to eq(idx)
            expect(node.data).to eq(letters[idx])
          end
        end
      end
    end

    describe '#each' do
      it 'returns an enumerator if no block given' do
        tree = SelfBalancingBinarySearchTree.new
        expect(tree.each).to be_a(Enumerator)
      end

      it 'can map over each' do
        10.times do
          tree = SelfBalancingBinarySearchTree.new
          add_at_random(tree)
          concat = ''
          sum = 0
          tree.each do |value, data|
            concat += data
            sum += value
          end
          expect(concat).to eq('abcdefghijk')
          expect(sum).to eq(55)
        end
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

      it 'more complicated right side case' do
        expected_left = tree.add_element(0, 'a')
        expected_right = tree.add_element(2, 'b')
        expected_root = tree.add_element(1, 'c')
        expect(tree.root.height).to eq(1)
        expect(tree.root.value).to eq(expected_root.value)
        expect(tree.root.data).to eq(expected_root.data)
        expect(tree.root.left_child.value).to eq(expected_left.value)
        expect(tree.root.left_child.data).to eq(expected_left.data)
        expect(tree.root.right_child.value).to eq(expected_right.value)
        expect(tree.root.right_child.data).to eq(expected_right.data)
      end

      it 'more complicated left side case' do
        expected_right = tree.add_element(1, 'b')
        expected_left = tree.add_element(-1, 'a')
        expected_root = tree.add_element(0, 'c')
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
