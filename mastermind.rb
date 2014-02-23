require 'set'

class MasterMind

  @@colours = ["red", "blue", "green", "mint", "white", "lavendar"]

  def initialize()
    @max_tries = 12
    @guesses = Array.new()
    @code = nil
    @all_codes = Array.new()
    generate_all_codes
  end

  def self.draw_colour_legend()
    print "colours: "
    @@colours.each do |colour|
      print "#{colour[0]}: #{colour} "
    end
    print "\n"
  end

  def ended?()
    if @guesses.size > @max_tries
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
    MasterMind.draw_colour_legend
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
    return if !is_legal?(guess)
    if(@code.nil?)
      @code = Array.new(4)
      @code = pick_code
    end

    if guess.size > @code.size
      puts "illegal guess: too many colours"
      return
    end
    @guesses.push(check_code(guess))
  end

  def solve(user_code)
    return if !is_legal?(user_code)
    @code = user_code
    guess = pick_code
    while(!ended?)
      make_guess(guess)
      #choose our next guess so that it'll give the same score if our first guess was the code

      #draw_board
    end
  end

  private
  def check_code(guess_array, code = nil)
    guess_orig = guess_array.dup
    num_correct = 0;
    code = @code.dup if code.nil?
    for i in 0..@code.size-1
      if(guess_array[i] == @code[i])
        num_correct = num_correct + 1
        guess_array[i] = nil
        code[i] = nil
      end
    end
    puts "num_correct #{num_correct}"
    num_almost = 0;
    for i in 0..guess_array.size-1
      if (!guess_array[i].nil? && code.include?(guess_array[i]))
        num_almost = num_almost + 1
        for j in 0..code.size-1
          if(code[j]==guess_array[i])
            code[j] = nil
          end
        end
        guess_array[i] = ""
      end
    end
    puts "num_almost #{num_almost}"
    return :guess => guess_orig, :correct => num_correct, :almost => num_almost
    #@guesses.push(:guess => guess_orig, :correct => num_correct, :almost => num_almost)
  end

  def generate_all_codes()
    for i in 0..5
      for j in 0..5
        for k in 0..5
          for l in 0..5
            @all_codes.push([@@colours[i][0], @@colours[j][0], @@colours[k][0], @@colours[l][0]])
          end
        end
      end
    end
  end

  def pick_code()
    rand = Random.new()
    return @all_codes[rand.rand(@all_codes.length()-1)]
  end

  def draw_feedback_legend()
    puts ""
    puts ".: correct colour and position\n^:correct colour"
  end

  def is_legal?(code)
    if(code.length != 4)
      puts "Code illegal length. Please try again"
      return false
    elsif(!code.to_set.subset? @@colours.collect{|colour| colour[0]}.to_set)
      puts "illegal colours in code. Please try again"
      return false
    end
    return true
  end

end

puts "Welcome to Mastermind!"
puts "Enter c to create a code, otherwise press enter to guess"
game = MasterMind.new
if gets.chomp().downcase() == "c"
  puts "create a code, of exactly 4 letters, for the computer to guess:"
  MasterMind.draw_colour_legend
  user_code = gets.chomp()
  game.solve(user_code.split(//))
else
  game.draw_board
  while(!game.ended?)
    puts "make a guess:"
    guess = gets.chomp()
    game.make_guess(guess.split(//))
    game.draw_board
  end
end

