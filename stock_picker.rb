def stock_picker(stock_prices)
  buy_day = 0
  sell_day = 0
  max_profit = -1.0/0 # neg. infinity
  stock_prices.each_with_index do |buy_price, i|
    stock_prices[i+1..-1].each_with_index do |sell_price, j|
      #puts "buy_price #{buy_price}, index #{i}, sell_price #{sell_price}, index #{j}, profit #{sell_price-buy_price}"
      if(sell_price - buy_price > max_profit)
        max_profit = sell_price - buy_price
        buy_day = i
        sell_day = j+i+1 # inner array indices start at i+1 of the original array
      end
    end
  end
  #puts "best buy day: #{buy_day} best sell day: #{sell_day} for a profit of #{max_profit}"
  return [buy_day, sell_day]
end

puts "Enter stock prices, one for each hypothetical day, seperated by commas:"
user_prices = gets.chomp.split(',').map { |price| price.to_i }
puts stock_picker(user_prices)

