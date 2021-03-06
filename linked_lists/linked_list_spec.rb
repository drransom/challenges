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

  context 'equality' do
    describe '#==' do
      it 'nodes with the same value are ==' do
        x = DLLNode.new(0)
        y = DLLNode.new(0)
        expect(x == y).to be(true)
      end

      it 'nodes with different values are not ==' do
        x = DLLNode.new(0)
        y = DLLNode.new(10)
        expect(x == y).to be(false)
      end

      it 'nodes whose objects are different are still ==' do
        x = DLLNode.new([1])
        y = DLLNode.new([1])
        expect(x == y).to be(true)
      end

      it 'nodes are == to values' do
        x = DLLNode.new(0)
        expect(x == 0).to be(true)
      end

      it 'nodes are not == to the wrong value' do
        x = DLLNode.new(0)
        expect(x == 5).to be(false)
      end
    end

    describe '#hash' do
      it 'nodes hash to the same value' do
        x = DLLNode.new(0)
        y = DLLNode.new(0)
        expect(x.hash == y.hash).to be(true)
      end

      it 'nodes with different values hash to different values' do
        x = DLLNode.new(0)
        y = DLLNode.new(10)
        expect(x.hash == y.hash).to be(false)
      end
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

    describe '#insert' do

      it 'inserts at the correct position' do
        list.insert(3, 5)
        expect(list[3]).to eq(5)
      end

      it 'bumps items in the list' do
        list.insert(3, 5)
        expect(list[4]).to eq(4)
      end

      it 'length of list is indexed' do
        list.insert(3, 5)
        expect(list.length).to eq(5)
      end

      it 'inserts at first index' do
        list.insert(0, 10)
        expect(list[0]).to eq(10)
        expect(list.first).to eq(10)
        expect(list[1]).to eq(1)
      end

      it 'inserts after last index' do
        list.insert(4, 10)
        expect(list[4]).to eq(10)
        expect(list.last).to eq(10)
        expect(list[3]).to eq(4)
      end

      it 'inserts at negative index' do
        list.insert(-2, 10)
        expect(list[2]).to eq(10)
      end

      it 'bumps items with negative index' do
        list.insert(-2, 10)
        expect(list[3]).to eq(3)
      end

      it 'positive index out of bounds' do
        expect{ list.insert(5, 10) }.to raise_error(IndexError)
      end

      it 'negative index out of bounds' do
        expect { list.insert(-10, 10) }.to raise_error(IndexError)
      end

      it 'returns value inserted' do
        expect(list.insert(3, 5)).to eq(5)
      end
    end

    describe '#delete_at' do

      it 'deletes at the correct position' do
        list.delete_at(1)
        expect(list[1]).to eq(3)
      end

      it 'length of list is indexed' do
        list.delete_at(2)
        expect(list.length).to eq(3)
      end

      it 'deletes at first index' do
        list.delete_at(0)
        expect(list[0]).to eq(2)
        expect(list.first).to eq(2)
        expect(list[1]).to eq(3)
      end

      it 'deletes at last index' do
        list.delete_at(3)
        expect(list[3]).to eq(nil)
        expect(list.last).to eq(3)
        expect(list[2]).to eq(3)
      end

      it 'deletes at negative index' do
        list.delete_at(-2)
        expect(list[2]).to eq(4)
      end

      it 'positive index out of bounds' do
        expect{ list.delete_at(5) }.to raise_error(IndexError)
      end

      it 'negative index out of bounds' do
        expect { list.delete_at(-10) }.to raise_error(IndexError)
      end

      it 'returns value deleted' do
        expect(list.delete_at(3)).to eq(4)
      end
    end

    describe '#delete' do
      it 'basic case' do
        list = DoublyLinkedList.new([1, 0, 2, 3, 4, 3, 4, 3, 1, 2])
        list.delete(0)
        expect(list.length).to eq(9)
        expect(list[1]).to eq(2)
      end

      it 'empty list' do
        list = DoublyLinkedList.new
        expect { list.delete(0) }.to_not raise_error
        expect(list.length).to eq(0)
      end

      it 'multiple items' do
        list = DoublyLinkedList.new([1, 0, 2, 3, 4, 3, 5, 3, 1])
        list.delete(3)
        expect(list[3]).to eq(4)
        expect(list[4]).to eq(5)
        expect(list[5]).to eq(1)
        expect(list.length).to eq(6)
      end

      it 'first item' do
        list = DoublyLinkedList.new([1, 0, 2, 3, 4, 3, 4, 3, 1, 2])
        list.delete(1)
        expect(list.first).to eq(0)
        expect(list[0]).to eq(0)
        expect(list.length).to eq(8)
      end

      it 'last item' do
        list = DoublyLinkedList.new([1, 0, 2, 3, 4, 3, 4, 3, 1, 2])
        list.delete(2)
        expect(list.last).to eq(1)
        expect(list[-1]).to eq(1)
        expect(list.length).to eq(8)
      end

      it 'returns value deleted' do
        list = DoublyLinkedList.new([1, 0, 2, 3, 4, 3, 4, 3, 1, 2])
        expect(list.delete(2)).to eq(2)
      end

      it 'item is not in list' do
        list = DoublyLinkedList.new([1, 0, 2, 3, 4, 3, 4, 3, 1, 2])
        expect{ list.delete(5) }.to_not raise_error
        expect(list.length).to eq(10)
        expect(list.delete(10)).to eq(nil)
      end

      it 'return value is deleted object rather than deleted value' do
        x = [1]
        list = DoublyLinkedList.new([[1], 0, x])
        expect(list.delete([1])).to be(x)
      end

    end

  end

  context 'equality' do
    describe "#==" do
      subject(:list) { DoublyLinkedList.new([1, 0, 2, 3, 4, 3, 4, 3, 1, 2]) }
      it 'list is equal to itself' do
        expect(list == list).to be(true)
      end

      it 'list is equal to another list with the same values' do
        other_list = DoublyLinkedList.new([1, 0, 2, 3, 4, 3, 4, 3, 1, 2])
        expect(list == other_list).to be(true)
      end

      it "list is not equal to another list with different values" do
        other_list = DoublyLinkedList.new([1, 3, 2, 3, 4, 3, 4, 3, 1, 2])
        expect(list == other_list).to be(false)
      end

      it "list is not equal to another list that has the same initial values" do
        other_list = DoublyLinkedList.new([1, 0, 2, 3, 4, 3, 4, 3, 1, 2, 3])
        expect(list == other_list).to be(false)
      end
    end

    describe "#hash" do
      subject(:list) { DoublyLinkedList.new([1, 0, 2, 3, 4, 3, 4, 3, 1, 2]) }
      it 'list\'s hash is equal to itself' do
        expect(list.hash == list.hash).to be(true)
      end

      it 'another list with the same values' do
        other_list = DoublyLinkedList.new([1, 0, 2, 3, 4, 3, 4, 3, 1, 2])
        expect(list.hash == other_list.hash).to be(true)
      end

      it "another list with different values" do
        other_list = DoublyLinkedList.new([1, 3, 2, 3, 4, 3, 4, 3, 1, 2])
        expect(list.hash == other_list.hash).to be(false)
      end

      it "another list that has the same initial values" do
        other_list = DoublyLinkedList.new([1, 0, 2, 3, 4, 3, 4, 3, 1, 2, 3])
        expect(list.hash == other_list.hash).to be(false)
      end
    end
  end

  context 'to other types' do
    describe '#to_a' do
      it 'converts to an array' do
        list = DoublyLinkedList.new([1, 2, 3])
        expect(list.to_a).to eq([1, 2, 3])
      end

      it 'does not modify the original list' do
        list = DoublyLinkedList.new([1, 2, 3])
        list.to_a
        expect(list).to eq(DoublyLinkedList.new([1, 2, 3]))
      end

      it 'empty list' do
        list = DoublyLinkedList.new
        expect(list.to_a).to eq([])
      end
    end

    describe "to_s" do
      it 'converts to a string' do
        list = DoublyLinkedList.new([1, 2, 3])
        expect(list.to_s).to be_a(String)
      end

      it 'produces the desired value' do
        list = DoublyLinkedList.new([1, 2, 3])
        expect(list.to_s).to eq([1, 2, 3].to_s)
      end

      it 'does not modify the original list' do
        list = DoublyLinkedList.new([1, 2, 3])
        list.to_s
        expect(list).to eq(DoublyLinkedList.new([1, 2, 3]))
      end

      it 'empty list' do
        list = DoublyLinkedList.new
        expect(list.to_s).to eq([].to_s)
      end
    end

    describe "to_h" do
      it 'converts to a hash' do
        list = DoublyLinkedList.new([[1, 2], [2, 2], [3, 2]])
        expect(list.to_h).to be_a(Hash)
      end

      it 'produces the desired value' do
        list = DoublyLinkedList.new([[1, 2], [2, 2], [3, 2]])
        expect(list.to_h).to eq({1 => 2, 2 => 2, 3 => 2})
      end

      it 'does not modify the original list' do
        list = DoublyLinkedList.new([[1, 2], [2, 2], [3, 2]])
        list.to_h
        expect(list).to eq(DoublyLinkedList.new([[1, 2], [2, 2], [3, 2]]))
      end

      it 'empty list' do
        list = DoublyLinkedList.new
        expect(list.to_h).to eq({})
      end
    end
  end

  context Enumerable do
    subject(:list) { DoublyLinkedList.new([1, 0, 2, 3, 4, 3, 4, 3, 1, 2]) }
    describe '#each' do
      it 'enumerates over each' do
        count = 0
        test_proc = Proc.new { |elem| count += 1 if elem == 2 }
        list.each &test_proc
        expect(count).to eq(2)
      end

      it 'returns in enumerable if no block given' do
        expect(list.each).to be_a(Enumerator)
      end
    end

    describe '#map' do
      subject(:list) { DoublyLinkedList.new([1, 0, 2, 3, 4, 3, 4, 3, 1, 2]) }
      it 'successfully maps' do
        answer = DoublyLinkedList.new([2, 0, 4, 6, 8, 6, 8, 6, 2, 4])
        prc = Proc.new { |x| x* 2 }
        expect(list.map &prc).to eq(answer)
      end

      it 'does not modify the original list' do
        prc = Proc.new { |x| x * 2 }
        answer = list.map &prc
        expect(answer).to_not be(list)
        expect(list[0]).to eq(1)
      end

      it 'no block given' do
        expect(list.map).to be_a(Enumerator)
      end
    end
  end
end
