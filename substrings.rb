def substrings(word, dictionary)
  results = {}
  dictionary.each do |w|
    current = word.downcase
    w = w.downcase
    while not current.index(w).nil?
      index = current.index(w)
      current = current[index+1..-1]
      results.has_key?(w) ? results[w] += 1 : results[w] = 1
    end
  end
  return results
end

puts "Word:"
word = gets.chomp
puts "Substrings dictionary, comma delimited:"
dictionary = gets.chomp.split(",").map(&:strip)

puts substrings(word, dictionary)
