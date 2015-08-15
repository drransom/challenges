require 'rspec'
require_relative 'linked_list_problems.rb'

describe LinkedListNode do
  context 'initialization' do
    it "can be initialized" do
      expect { LinkedListNode.new(0, nil) }.to_not raise_error
    end

    it 'does not require a parent to be passed in' do
      expect { LinkedListNode.new(0) }.to_not raise_error
    end
  end

  context 'setting values' do
    it '#value' do
      x = LinkedListNode.new(0)
      expect(x.value).to eq(0)
    end

    it '#value=' do
      x = LinkedListNode.new(5)
      x.value = 0
      expect(x.value).to eq(0)
    end

  end

  context 'setting parent' do
    subject(:node) { LinkedListNode.new(0) }

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

describe LinkedList do
  subject(:list) { LinkedList.new }
end
