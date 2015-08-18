require 'rspec'
require_relative 'linked_list_dups.rb'

describe DoublyLinkedList do
  context 'deleting duplicates' do
    describe '#remove_duplicates!' do
      it 'handles one duplicate' do
        list = DoublyLinkedList.new([1, 1])
        answer = DoublyLinkedList.new([1])
        list.remove_duplicates!
        expect(list).to eq(answer)
      end

      it 'handles multiple duplicates' do
        list = DoublyLinkedList.new([1, 1, 1])
        answer = DoublyLinkedList.new([1])
        list.remove_duplicates!
        expect(list).to eq(answer)
      end

      it 'handles a more complicated case' do
        list = DoublyLinkedList.new([1, 3, 3, 1, 2, 5, 2])
        answer = DoublyLinkedList.new([1, 3, 2, 5])
        list.remove_duplicates!
        expect(list).to eq(answer)
      end

      it 'empty list' do
        list = DoublyLinkedList.new
        answer = DoublyLinkedList.new
        list.remove_duplicates!
        expect(list).to eq(answer)
      end

      it 'returns the original list' do
        list = DoublyLinkedList.new([1, 0, 2, 3, 4, 3, 4, 3, 1, 2])
        expect(list.remove_duplicates!).to eq(list)
      end
    end

    describe '#remove_duplicates!' do
      it 'handles one duplicate' do
        list = DoublyLinkedList.new([1, 1])
        answer = DoublyLinkedList.new([1])
        list.remove_duplicates_without_buffer!
        expect(list).to eq(answer)
      end

      it 'handles multiple duplicates' do
        list = DoublyLinkedList.new([1, 1, 1])
        answer = DoublyLinkedList.new([1])
        list.remove_duplicates_without_buffer!
        expect(list).to eq(answer)
      end

      it 'handles a more complicated case' do
        list = DoublyLinkedList.new([1, 3, 3, 1, 2, 5, 2])
        answer = DoublyLinkedList.new([1, 3, 2, 5])
        list.remove_duplicates_without_buffer!
        expect(list).to eq(answer)
      end

      it 'empty list' do
        list = DoublyLinkedList.new
        answer = DoublyLinkedList.new
        list.remove_duplicates_without_buffer!
        expect(list).to eq(answer)
      end

      it 'returns the original list' do
        list = DoublyLinkedList.new([1, 0, 2, 3, 4, 3, 4, 3, 1, 2])
        expect(list.remove_duplicates_without_buffer!).to eq(list)
      end
    end
  end
end
