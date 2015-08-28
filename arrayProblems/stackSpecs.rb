require 'rspec'
require_relative 'stacks.rb'

describe SortStack do

  describe '#initialize' do
    it 'can push items onto the stack' do
      stack = SortStack.new([3, 2, 1])
      expect(stack.peek).to eq(1)
    end
  end

  describe '#push and #peek' do
    subject(:stack) { SortStack.new }
    it 'can push items onto the stack and peek at them' do
      stack.push(3)
      expect(stack.peek).to eq(3)
    end

    it 'multiple items' do
      stack.push(3)
      stack.push(5)
      expect(stack.peek).to eq(5)
    end

    it 'push returns the pushed value' do
      expect(stack.push(5)).to eq(5)
    end

    it '#<< aliases #push' do
      stack << 3
      expect(stack.peek).to eq(3)
    end
  end

  describe '#pop' do
    subject(:stack) { SortStack.new([1, 3, 5]) }
    it 'can pop items off the stack' do
      stack.pop
      expect(stack.peek).to eq(3)
    end

    it 'multiple items' do
      stack.pop
      stack.pop
      expect(stack.peek).to eq(1)
    end

    it 'returns the popped item' do
      expect(stack.pop).to eq(5)
    end

    it 'empty stack' do
      stack.pop
      stack.pop
      stack.pop
      expect(stack.pop).to eq(nil)
    end
  end

  describe 'push and pop together' do
    subject(:stack) { SortStack.new }

    it 'can push and then pop' do
      stack.push(5)
      stack.push(3)
      stack.pop
      expect(stack.peek).to eq(5)
    end

    it 'push, then pop, then push' do
      stack.push(5)
      stack.push(3)
      stack.pop
      stack.push(10)
      expect(stack.peek).to eq(10)
    end
  end

  describe '#length' do
    subject(:stack) { SortStack.new }

    it 'empty stack' do
      expect(stack.length).to eq(0)
    end

    it 'not empty' do
      stack.push(0)
      stack.push(0)
      expect(stack.length).to eq(2)
    end

    it 'remove items' do
      stack.push(0)
      stack.push(2)
      stack.pop
      expect(stack.length).to eq(1)
    end

  end

  describe '#empty?' do
    subject(:stack) { SortStack.new }

    it 'empty stack' do
      expect(stack.empty?).to be_truthy
    end

    it 'not empty' do
      stack.push(1)
      expect(stack.empty?).to be_falsy
    end

    it 'add and remove elements' do
      stack.push(2)
      stack.push(3)
      stack.pop
      stack.pop
      expect(stack.empty?).to be_truthy
    end
  end

  describe '#==' do
    subject(:stack) { SortStack.new }
    let(:other_stack) { SortStack.new }

    it 'empty stacks' do
      expect(stack == other_stack).to be_truthy
    end

    it 'stacks not equal' do
      stack.push(3)
      expect(stack == other_stack).to be_falsy
    end

    it 'stacks changed to be equal' do
      stack.push(5)
      stack.push(3)
      stack.pop
      other_stack.push(5)
      expect(stack == other_stack).to be_truthy
    end

    it 'nonempty nonequal stacks' do
      stack.push(5)
      other_stack.push(5)
      other_stack.push(3)
      expect(stack == other_stack).to be_falsy
    end
  end

  describe '#hash' do
    subject(:stack) { SortStack.new }
    subject(:other_stack) { SortStack.new }


    it 'empty stacks' do
      expect(stack.hash).to eq(other_stack.hash)
    end

    it 'stacks not equal' do
      stack.push(3)
      expect(stack.hash).to_not eq(other_stack.hash)
    end

    it 'stacks changed to be equal' do
      stack.push(5)
      stack.push(3)
      stack.pop
      other_stack.push(5)
      expect(stack.hash).to eq(other_stack.hash)
    end

    it 'nonempty nonequal stacks' do
      stack.push(5)
      other_stack.push(5)
      other_stack.push(3)
      expect(stack == other_stack).to_not eq(other_stack.hash)
    end
  end

  describe '#sort' do
    subject(:stack) { SortStack.new}
    it 'sorts one element' do
      stack.push(3)
      sorted = SortStack.new([3])
      stack.sort
      expect(stack).to eq(sorted)
    end

    it 'multiple elements' do
      items = [3, 5, 1, 3, 2, 6, 9, 7, 2]
      items.each { |item| stack.push(item) }
      sorted = SortStack.new(items.sort)
      stack.sort
      expect(stack).to eq(sorted)
    end

    it 'returns the stack' do
      stack.push(5)
      stack.push(2)
      expect(stack.sort).to be(stack)
    end

    it 'no elements' do
      stack.sort
      expect(stack).to eq(SortStack.new)
    end

    it 'does not call the built in sort method' do
      stack.push(3)
      stack.push(1)
      contents = stack.instance_variable_get(:contents)
      stack.sort
      expect(contents).to_not have_received(:sort)
    end

    it 'can sort with a proc' do
      stack.push(3)
      stack.push(2)
      stack.push(5)
      sorted = SortStack.new([5, 3, 1])
      stack.sort do |a, b|
        if a < b
          1
        elsif a == b
          0
        else
          -1
        end
      end
      expect(stack).to eq(sorted)
    end
  end
end
