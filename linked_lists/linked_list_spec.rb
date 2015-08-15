require 'rspec'
require_relative 'linked_list_problems.rb'

describe DLLNode do
  context 'initialization' do
    it "can be initialized" do
      expect { DLLNode.new(0) }.to_not raise_error
    end
  end

  context 'setting values' do
    it '#value' do
      x = DLLNode.new(0)
      expect(x.value).to eq(0)
    end

    it '#value=' do
      x = DLLNode.new(5)
      x.value = 0
      expect(x.value).to eq(0)
    end

  end

  context 'setting child' do
    subject(:node) { DLLNode.new(0) }

    it '#child=' do
      child = double("child")
      expect {node.child = child}.to_not raise_error
    end

    it '#child' do
      child = double("child")
      node.child = child
      expect(node.child).to eq(child)
    end

  end

  context 'setting parent' do
    subject(:node) { DLLNode.new(0) }

    it '#parent=' do
      parent = double("parent")
      expect {node.parent = parent}.to_not raise_error
    end

    it '#parent' do
      parent = double("parent")
      node.parent = parent
      expect(node.parent).to eq(parent)
    end
  end
end

describe DoublyLinkedList do

  context 'initialization' do
    it 'can be initialized' do
      expect {DoublyLinkedList.new}.to_not raise_error
    end

    it 'can take an array as an argument' do
      expect { DoublyLinkedList.new([1, 2, 3]) }.to_not raise_error
    end

    it 'adds the array as the arguments' do
      list = DoublyLinkedList.new([1, 2, 3])
      expect(list.first).to eq(1)
      expect(list.last).to eq(3)
      expect(list.length).to eq(3)
    end
  end

  context 'push and unshift' do
    subject(:list) { DoublyLinkedList.new }
    describe '#push' do
      it 'does not raise error' do
        expect { list.push(5) }.to_not raise_error
      end

      it 'raises error if nothing is pushed' do
        expect { list.push() }.to raise_error
      end

      it 'returns the pushed value' do
        expect(list.push(5)).to eq(5)
      end

      it 'pushes adds to the end of the list' do
        list.push(5)
        expect(list.last).to eq(5)
        list.push(3)
        expect(list.last).to eq(3)
      end
    end

    describe '#unshift' do
      it 'does not raise error' do
        expect { list.unshift(5) }.to_not raise_error
      end

      it 'raises error if nothing is unshifted' do
        expect { list.unshift() }.to raise_error
      end

      it 'returns the unshifted value' do
        expect(list.unshift(5)).to eq(5)
      end

      it 'unshift adds to the end of the list' do
        list.unshift(5)
        expect(list.first).to eq(5)
        list.unshift(3)
        expect(list.first).to eq(3)
      end
    end
  end
end
