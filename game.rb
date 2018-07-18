require_relative 'board' #permet de relier le fichier board avec game.rb
require_relative 'player' #permet de relier le fichier player avec game.rb

class Game

    def initialize
        p "Welcome to my amazing game : "
        p "========== TIC TAC TOE =========="


        p "Name of the player 1 : "
        #saisi du nom par le joueur 1
        name_1 = gets.chomp
        #le player 2 a le name_1 et le X
        @player1 = Player.new(name_1, "X")

        p "Name of the player 2 : "
        #saisi du nom par le joueur 2
        name_2 = gets.chomp
        #le player 2 a le name_2 et le Ø
        @player2 = Player.new(name_2, "Ø")

        p "Player 1 is now #{name_1}, player 2 is now #{name_2}"
        p "#{name_1} use X, #{name_2} use Ø"

        #le premier joueur a jouer est le player1
        @current_player = @player1
        @board = Board.new

    end

    #methode permettant le changement de joueur a chaque tour
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

        #on passe la saisie du joueur en integer
        if target.to_i == @board.grid[target.to_i - 1]
            @board.grid[target.to_i - 1] = @current_player.marker
        else
            #message d’erreur si le chiffre entre a deja ete prit ou si ce n’est pas compris entre 1 et 9
            puts "You can’t, please try again :)"
            switch_players
        end
    end

    #methode start permettant de lancer le jeux
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
            puts "Game over ! It’s a draw !"
        end
    end

    #si une condition de winning_condition est vrai ou qu’il n’y a plus de case de libre. on renvoi game over
    def game_over?
        @board.winning_condition? ||
        @board.grid.all? {|cell| cell.is_a? String}
    end
end

#permet de lancer le jeux
game = Game.new
game.start