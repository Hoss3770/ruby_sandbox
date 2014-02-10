class MasterMind

  @@colours = ["red", "blue", "green", "mint", "white", "lavendar"]

  def initialize()
    @max_tries = 12
    @guesses = Array.new()
    @code = Array.new(4)
    pick_code
    puts @code.join("")
  end

  def self.draw_colour_legend()
    print "colours: "
    @@colours.each do |colour|
      print "#{colour[0]}: #{colour} "
    end
  end

  def ended?()
    if @guesses.size >= @max_tries
      puts "out of moves! you lost."
      puts "the answer was #{@code.join("")}"
      return true
    elsif !@guesses[-1].nil? && @guesses[-1][:correct] == 4
      puts "you win!"
      return true
    end
    return false
  end

  def draw_board()
    self.draw_colour_legend
    draw_feedback_legend
    puts "*************"
    @guesses.each do |guessed|
      print guessed[:guess].join(" ")
      print " |"
      for i in 0..guessed[:correct]-1
        print "."
      end
      for i in 0..guessed[:almost]-1
        print "^"
      end
      print "\n"
    end
    tries_to_go = @max_tries - @guesses.size - 1
    0.upto(tries_to_go) do
      puts "_ _ _ _"
    end
    puts "*************"
  end

  def make_guess(guess)
    guess_array = guess.split(//)
    if guess_array.size > @code.size
      puts "illegal guess: too many colours"
      return
    end
    check_code(guess_array)
  end

  private
  def check_code(guess_array)
    guess_orig = guess_array.dup
    num_correct = 0;
    code_copy = @code.dup
    for i in 0..@code.size-1
      if(guess_array[i] == @code[i])
        num_correct = num_correct + 1
        guess_array[i] = nil
        code_copy[i] = nil
      end
    end
    puts "num_correct #{num_correct}"
    num_almost = 0;
    for i in 0..guess_array.size-1
      if (!guess_array[i].nil? && code_copy.include?(guess_array[i]))
        num_almost = num_almost + 1
        for j in 0..code_copy.size-1
          if(code_copy[j]==guess_array[i])
            code_copy[j] = nil
          end
        end
        guess_array[i] = ""
      end
    end
    puts "num_almost #{num_almost}"
    @guesses.push(:guess => guess_orig, :correct => num_correct, :almost => num_almost)
  end

  def pick_code()
    rand = Random.new()
    for i in 0..3
      @code[i] = @@colours[rand.rand(6)][0]
    end
  end

  def draw_feedback_legend()
    puts ""
    puts ".: correct colour and position\n^:correct colour"
  end
end

puts "Welcome to Mastermind!"
puts "Enter c to create a code, otherwise press enter to guess"
if gets.chomp().downcase() == "c"
  puts "create a code for the computer to guess:"
  MasterMind.draw_colour_legend
else
  game = MasterMind.new
  game.draw_board
  while(!game.ended?)
    puts "make a guess:"
    guess = gets.chomp()
    game.make_guess(guess)
    game.draw_board
  end
end
