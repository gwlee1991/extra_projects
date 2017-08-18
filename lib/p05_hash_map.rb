require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count
  include Enumerable
  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[key.hash % num_buckets].each do |link|
      return true if link.key == key
    end
    false
  end

  def set(key, val)
    mod = key.hash % num_buckets
    if @store[mod].include?(key)
      @store[mod].update(key,val)
    else
      @store[mod].append(key, val)
      @count += 1
    end
    if @count > num_buckets
      resize!
    end
  end

  def get(key)
    mod = key.hash % num_buckets
    if @store[mod].include?(key)
      @store[mod].each do |link|
        if link.key == key
          return link.val
        end
      end
    end
  end

  def delete(key)
    mod = key.hash % num_buckets
    @store[mod].each do |link|
      if link.key == key
        link.remove
        @count -= 1
        break
      end
    end
    key
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each do |link|
        prc.call(link.key, link.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    dup = @store.dup
    @store = Array.new(num_buckets * 2) {LinkedList.new}
    @count = 0
    dup.each do |bucket|
      bucket.each do |link|
        key= link.key
        val = link.val
        set(key, val)
      end
    end
  end

  # def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  # end
end
