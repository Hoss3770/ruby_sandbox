module Enumerable
  def my_each
    if block_given?
      for i in 0..self.size-1
        yield self[i]
      end
    else
      return self
    end
  end

  def my_each_with_index
    if block_given?
      for i in 0..self.size-1
        yield self[i], i
      end
    else
      return self
    end
  end
end

[1,2,3].each { |i| puts i }
[1,2,3].my_each { |i| puts i }
p [1,2,3].each
p [1,2,3].my_each

[1,2,3].each_with_index { |item, index| puts "item #{item} index #{index}" }
[1,2,3].my_each_with_index { |item, index| puts "item #{item} index #{index}" }

p [1,2,3,4,5].select { |num|  num.even?  }   #=> [2, 4]
p [1,2,3,4,5].my_select { |num|  num.even?  }   #=> [2, 4]

