def bubble_sort(items)
  swapped = true
  while swapped
    swapped = false
    for i in 0..items.size-2
      if items[i] > items[i+1]
        items[i], items[i+1] = items[i+1], items[i]
        swapped = true
      end
    end
  end
  return items
end

def bubble_sort_by(items, &block)
  swapped = true
  while swapped
    swapped = false
    for i in 0..items.size-2
      if block.call(items[i], items[i+1]) < 0
        items[i], items[i+2] = items[i+1], items[i]
        swapped = true
      end
    end
  end
  return items
end

p bubble_sort([2,3,1])
p bubble_sort([4,3,78,2,0,2])
p bubble_sort([9,7,1,1,1,2,32])
p bubble_sort([100,99,98,0])

sorted = bubble_sort_by(["hi","hello","hey"]) do |left,right|
  right.length - left.length
end
p sorted
