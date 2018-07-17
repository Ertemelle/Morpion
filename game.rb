require_relative 'board'
require_relative 'player'

class Game

	def initialize
		p "Welcome to my amazing game : "
		p "========== TIC TAC TOE =========="


		p "Name of the player 1 : "
		name_1 = gets.chomp
		@player1 = Player.new(name_1, "X")

		p "Name of the player 2 : "
		name_2 = gets.chomp
		@player2 = Player.new(name_2, "0")
		
		p "Player 1 is now #{name_1}, player 2 is now #{name_2}"
		p "#{name_1} use X, #{name_2} use 0"

		@current_player = @player1
		@board = Board.new

	end

	def switch_players
		if @current_player == @player1
			@current_player = @player2
		else
			@current_player = @player1
		end
	end

	def move
		puts "#{@current_player.name}, where do you want to move ? (puts a number between 1 and 9) : "
		target = gets.chomp
		if target.to_i == @board.grid[target.to_i - 1]
			@board.grid[target.to_i - 1] = @current_player.marker
		else
			puts "You can't, please try again :)"
			switch_players
		end
	end

	def start
		loop do
			@board.display
			move
			if game_over?
				break
			else
				switch_players
			end
		end
		@board.display
		if @board.winning_condition?
			puts "Game over ! #{@current_player.name} won !"
		else
			puts "Game over ! It's a draw !"
		end
	end

	def game_over?
		@board.winning_condition? ||
		@board.grid.all? {|cell| cell.is_a? String}
	end
end

game = Game.new
