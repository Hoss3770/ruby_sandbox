class MasterMind

  def initialize()
    @max_tries = 2
    @guesses = Array.new()
    @colours = ["red", "blue", "green", "mint", "white", "lavendar"]
    @code = Array.new(4)
    pick_code
    puts @code
  end

  def ended?()
    return @guesses.size >= @max_tries
  end

  def draw_board()
    draw_colour_legend
    puts "*********"
    @guesses.each do |guessed|
      puts guessed
    end
    tries_to_go = @max_tries - @guesses.size - 1
    0.upto(tries_to_go) do
      puts "_ _ _ _"
    end
    puts "*********"
  end

  def make_guess(guess)
    guess_array = guess.split(//)
    if guess_array.size > @code.size
      puts "illegal guess: too many colours"
      return
    end
    @guesses.push(guess)
    check_code(guess_array)
  end

  private
  def check_code(guess_array)
    num_correct = 0;
    for i in 0..@code.size-1
      if(guess_array[i] == @code[i][0])
        num_correct = num_correct + 1;
      end
    end
    puts "num_correct #{num_correct}"
    
  end

  def pick_code()
    rand = Random.new()
    for i in 0..3
      @code[i] = @colours[rand.rand(6)]
    end
  end

  def draw_colour_legend()
    print "colours: "
    @colours.each do |colour|
      print "#{colour[0]}: #{colour} "
    end
    puts ""
  end

end

puts "Welcome to Mastermind! Can you crack the secret code?"
game = MasterMind.new
game.draw_board
while(!game.ended?)
  puts "make a guess:"
  guess = gets.chomp()
  game.make_guess(guess)
  game.draw_board
end

