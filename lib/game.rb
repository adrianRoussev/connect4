require './lib/board'
require './lib/turn'



class Game

  attr_reader :board, :turn

  def initialize
    @board = Board.new
    @turn = :X
    @start = true 
  end

  def greeting 
    @start ? (@start = false; "Welcome to Connect 4!") : nil
  end  

  def create_turn
    Turn.new(@turn, @board)
  end
  

  def switch_turn
    @turn = (@turn == :X) ? :O : :X
  end

  def computer_move
          best_move = @turn.predict_best_move(@player)
          column = best_move
          @board.make_move(column, @player)
        end

  def print_board
    output = ""
    output += ("A".."G").to_a.join(" ") + "\n"
  
    6.times.reverse_each do |row|
      row_output = []
  
      7.times.reverse_each do |column|
        position = column * @board.columns + row
        if @board.marker_positions_bit[:X] & (2**position) != 0
          row_output.unshift("X")
        elsif @board.marker_positions_bit[:O] & (2**position) != 0
          row_output.unshift("O")
        else
          row_output.unshift(".")
        end
      end
  
      output += row_output.join(" ") + "\n"
    end
    output
  end

  def play
    greeting
    while true
      system("clear")
      puts print_board
      turn = create_turn
      turn.player_move
      if @board.four_connected?(@turn) || @board.connect4?(@turn)
        puts "#{@turn} is the winner!"
        @next_start_player = (@turn == :X) ? :O : :X
        break
      elsif @board.board_full?
        puts "The game is a draw."
        @next_start_player = (@turn == :X) ? :O : :X
        break
      else
        switch_turn
        computer_turn
      end
    end
    play_again
  end
  
  def play_again
    puts "Would you like to play again? (Y/N)"
    input = gets.chomp.upcase
    if input == "Y"
      @board = Board.new
      @turn = @next_start_player
      @start = true
      play
    elsif input == "N"
      puts "Thanks for playing!"
    else
      puts "Invalid input. Please enter Y for yes or N for no."
      play_again
    end
  end
end 