class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    @next.prev = @prev
    @prev.next = @next
    @next = nil
    @prev = nil
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next unless empty?
  end

  def last
    @tail.prev unless empty?
  end

  def empty?
    return true if @head.next == @tail
    false
  end

  def get(key)
    each do |link|
      if link.key == key
        return link.val
      end
    end
    nil
  end

  def include?(key)
    each do |link|
      if link.key == key
        return true
      end
    end
    false
  end

  def append(key, val)
    node = Node.new(key, val)
    node.prev = @tail.prev
    node.next = @tail
    @tail.prev.next = node
    @tail.prev = node
  end

  def update(key, val)
    each do |link|
      if link.key == key
        link.val = val
      end
    end
  end

  def remove(key)
    each do |link|
      if link.key == key
        link.remove
        break
      end
    end
    nil
  end

  def each (&prc)
    nxt = @head.next
    while nxt != @tail
      prc.call(nxt)
      nxt = nxt.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
