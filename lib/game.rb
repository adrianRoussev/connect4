require './lib/board'
require './lib/turn'
class Game
  attr_reader :board, :turn, :player_marker, :computer_marker, :scores

  def initialize
    @start = true
    @board = Board.new
    @turn = Turn.new(@board)
    @player_marker = nil
    @computer_marker = nil
    @scores = []
  end

  def greeting
    @start ? (@start = false; puts "Welcome to Connect 4!") : nil
  end

  def create_turn
    Turn.new(@board)
  end

  

  # def choose_marker
  #   loop do
  #     print "Choose your marker (X or O): "
  #     marker = gets.chomp.upcase
  #     marker_strings = ["X", "O"]
  #     if marker_strings.include?(marker)
  #       @player_marker = marker.to_sym
  #       @computer_marker = (@player_marker == 'X' ? 'O' : 'X').to_sym
  #       break
  #     else
  #       puts "Invalid marker. Please choose 'X' or 'O'."
  #     end
  #   end
  # end

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

  def player_move
    @player_marker = :X
        @computer_marker = :O
    puts "X, it's your turn."
    input = gets.chomp.upcase
    valid_columns = ("A".."G").to_a
    # column = valid_columns.index(input)
    # if @board.current_position_ar.fetch(column) == @board.final_position_ar.fetch(column)  
    #   puts "Invalid column. Please enter a column (A-G):"
    #   input = gets.chomp.upcase
    # end
    until input.is_a?(String) && valid_columns.include?(input.upcase)
      puts "Invalid column. Please enter a column (A-G):"
      input = gets.chomp.upcase
     
    end

    column_index = valid_columns.index(input.upcase)
    @board.make_move(column_index, @player_marker)
  end

  # def computer_move
  #   puts "Computer's turn!"
 
  #   selected_move = turn.predict_best_move(@computer_marker)
  #   @board.make_move(selected_move, @computer_marker)
  #   sleep(3)
    def computer_move
      best_move = @turn.predict_best_move(:O)
      @board.make_move(best_move, :O)
    end

  def display_result
    puts print_board
if game_over? 
    if @board.four_connected?(@player_marker)
      puts "Congratulations! You won!"
    elsif @board.four_connected?(@computer_marker)
      puts "Computer wins! Better luck next time."
    elsif board_full?
      puts "It's a draw!"
    end
  end
  end

  def game_over?
    @board.four_connected?(@player_marker) || @board.four_connected?(@computer_marker) || board_full?
  end
  
  
def round
    @board = Board.new
  greeting
  system 'clear'
  puts print_board
    puts "You will never beat me..."
    sleep(2)
   
    loop do
      puts print_board
     player_turn 
     if  @board.four_connected?(@player_marker) ==true || @board.four_connected?(@computer_marker) == true || @board.board_full? == true
    break
   else
    puts print_board
     computer_turn
     if  @board.four_connected?(@player_marker) ==true || @board.four_connected?(@computer_marker) == true || @board.board_full? == true
      break
     end
    end
  end

  
    display_result
    update_scores
  show_high_scores
  play_again?
  end

  def play
    loop do
      round
     display_result
      break unless play_again?
    end
    puts 'Thanks for playing!'
  end

  def computer_turn
  print_board
  computer_move
    sleep(2)
  end

def player_turn
  
  print_board
    player_move
    sleep(2)
  end
  

  def play_again?
    puts "Would you like to play again? (Y/N)"
    input = gets.chomp.upcase

    if input == "Y"
      @board = Board.new
      
      @start = true
      play
    elsif input == "N"
      puts "Thanks for playing!"
    else
      puts "Invalid input. Please enter Y for yes or N for no."
      play_again
    end
  end

  def game_over?
    if board.connect4?(player_marker)
      puts "Congratulations! You win!"
      true
    elsif board.connect4?(computer_marker)
      puts "Computer wins! Better luck next time!"
      true
    elsif board.board_full?
      puts "It's a draw!"
      true
    else
      false
    end
  end
  
  
  
  def reset_game
    board.reset
    puts "Starting a new game!"
  end

  def update_scores
    winner = nil

    if @board.connect4?(@player_marker)
      winner = 'Player'
    elsif @board.connect4?(@computer_marker)
      winner = 'Computer'
    end

    @scores << { winner: winner, timestamp: Time.now }
  end

  def show_high_scores
    puts "High Scores:"
    if @scores.empty?
      puts "No scores recorded yet."
    else
      @scores.each_with_index do |score, index|
        puts "#{index + 1}. #{score[:winner]} - #{score[:timestamp]}"
      end
    end
    puts
  end
end