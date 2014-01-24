class TicTacGame

  def initialize(playerX, playerO)
    @board = Array.new(3) { Array.new(3) }
		@playerX = playerX
		@playerY = playerO
    @ended = false
  end

  def game_ended?
    return @ended
  end

  def draw_board()
    @board.each_with_index do |row, row_index|
      row.each_with_index do |position, column_index|
				position_num = get_position_num(row_index, column_index)
        if position.nil?
          print "#{position_num}"
				else
					print "#{position.symbol}"
        end
        print row_index < 2 ? "_" : " "
        print "|" unless column_index >= 2
      end
      print "\n"
    end
  end

	def make_move(player, move_pos)
		@board = @board.map.with_index do |row, row_index|
			row = row.map.with_index do |position, column_index|
				position_num = get_position_num(row_index, column_index)
				if position_num == move_pos
					if position.nil?
						puts "setting position #{position_num} to player"
						position = player
					else
						puts "position already filled"
					end
				end
			end
		end
	end

  attr_accessor :playerX, :playerO, :ended

	private
	def get_position_num(n, j)
		return (n*@board.size)+j+1
	end

end

class Player
  def initialize(name, symbol)
    @name = name
		@symbol = symbol
  end
  def say_hi()
    puts "Hi! #{name}"
  end
  attr_accessor :name, :symbol
end

puts "Welcome to TicTacToe!"
puts "Player x name:"
nameX = gets.chomp
pX = Player.new(nameX, "X")
pX.say_hi
nameO = gets.chomp
pO = Player.new(nameO, "O")
pO.say_hi
game = TicTacGame.new(pX, pO)
puts "Game started."
while(!game.game_ended?)
	puts "#{pX.name} pick a position:"
  game.draw_board
	pos = gets.chomp.to_i
	game.make_move(pX, pos)
	game.draw_board
	puts "#{pO.name} pick a position:"
	game.draw_board
	pos = gets.chomp.to_i
	game.make_move(pO, pos)
	game.draw_board
	game.ended = true
end

