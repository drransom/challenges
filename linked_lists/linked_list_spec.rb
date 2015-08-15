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

    describe '#<<' do
      it 'aliases #push' do
        expect(list).to receive(:push).with(10)
        list << 10
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

  context 'pop and shift' do
    describe '#pop' do
      subject(:list) { DoublyLinkedList.new([1, 2, 3, 4]) }
      it 'can pop one item' do
        expect { list.pop }.to_not raise_error
      end

      it 'pop returns value of last item' do
        expect(list.pop).to eq(4)
      end

      it 'length changes after pop' do
        list.pop
        expect(list.length).to eq(3)
      end

      it 'last item is different after pop' do
        list.pop
        expect(list.last).to eq(3)
      end
    end

    describe '#shift' do
      subject(:list) { DoublyLinkedList.new([1, 2, 3, 4]) }
      it 'can shift one item' do
        expect { list.shift }.to_not raise_error
      end

      it 'shift returns value of last item' do
        expect(list.shift).to eq(1)
      end

      it 'length changes after shift' do
        list.shift
        expect(list.length).to eq(3)
      end

      it 'first item is different after shift' do
        list.shift
        expect(list.first).to eq(2)
      end
    end
  end

  context 'indexing' do
    subject(:list) { DoublyLinkedList.new([1, 2, 3, 4]) }

    describe '[]' do
      it 'basic cases' do
        expect(list[0]).to eq(1)
        expect(list[1]).to eq(2)
        expect(list[2]).to eq(3)
        expect(list[3]).to eq(4)
      end

      it 'index out of bounds' do
        expect(list[5]).to eq(nil)
      end

      it 'negative index' do
        expect(list[-1]).to eq(4)
        expect(list[-2]).to eq(3)
        expect(list[-3]).to eq(2)
        expect(list[-4]).to eq(1)
      end

      it 'negative index out of bounds' do
        expect(list[-5]).to eq(nil)
      end
    end

    describe '[]=' do
      it 'can set an index at a value' do
        list[2] = 10
        expect(list[2]).to eq(10)
      end

      it 'indexing resets first' do
        list[0] = 10
        expect(list.first).to eq(10)
      end

      it 'indexing resets last' do
        list[3] = 10
        expect(list.last).to eq(10)
      end

      it 'can set an index at a negative value' do
        list[-2] = 10
        expect(list[2]).to eq(10)
      end

      it 'raises an error if the index is out of bounds' do
        expect { list[5] = 10 }.to raise_error(IndexError)
      end

      it 'raises an error if a negative index is out of bounds' do
        expect { list[-5] = 10 }.to raise_error(IndexError)
      end
    end
  end

  context 'insert and delete' do
    subject(:list) { DoublyLinkedList.new([1, 2, 3, 4]) }

    describe 'insert' do
    end
  end
end
