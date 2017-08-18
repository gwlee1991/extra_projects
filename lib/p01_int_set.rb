class MaxIntSet
  def initialize(max)
    @store = Array.new(max)
  end

  def insert(num)
    raise 'Out of bounds' if num > @store.length || num < 0
    @store[num] = true
  end

  def remove(num)
    raise 'Out of bounds' if num > @store.length || num < 0
    @store[num] = false
  end

  def include?(num)
    return true if @store[num]
    false
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    return false if include?(num)
    @store[num % num_buckets].push(num)
    true
  end

  def remove(num)
    @store[num % num_buckets].delete(num)
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if @count == num_buckets
      resize!
    end
    @store[num % num_buckets].push(num)
    @count += 1
  end

  def remove(num)
    @store[num % num_buckets].delete(num)
    @count -= 1
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    dup = @store.dup
    @store = Array.new(num_buckets * 2) {Array.new}
    dup.each do |bucket|
      bucket.each do |num|
        @store[num % num_buckets].push(num)
      end
    end
  end
end
