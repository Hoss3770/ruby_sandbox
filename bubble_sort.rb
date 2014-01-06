def bubble_sort(items)
  for i in 0..items.size-1
    for j in i+1..items.size-2
      puts "i #{i} j #{j}"
      if items[i] > items[i+1]
        lesser = items[i]
        greater = items[i+1]
        items[i] = greater
        items[i+1] = lesser
      end
    end
  end
  return items
end

p bubble_sort([2,1])
p bubble_sort([2,3,1])
p bubble_sort([4,3,78,2,0,2])
