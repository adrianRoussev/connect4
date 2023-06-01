class Game

  attr_reader :board, :turn

  def initialize
    # @turn = :X
    @start = true 
    @board = Board.new
    @player_marker = nil
    @computer_marker = nil
    @scores = []
  end

  def greeting 
    @start ? (@start = false; "Welcome to Connect 4!") : nil
  end  

  # def create_turn
  #   Turn.new(@turn, @board)
  # end
  

  def switch_turn
    @turn = (@turn == :X) ? :O : :X
  end

  def choose_marker
    loop do
      print "Choose your marker (X or O): "
      marker = gets.chomp.upcase
      marker_strings = ["X", "O"]
      if marker_strings.include?(marker)
        @player_marker = marker.to_sym
        @computer_marker = (marker == 'X' ? 'O' : 'X').to_sym
        break
      else
        puts "Invalid marker. Please choose 'X' or 'O'."
      end
    end
  en


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
    valid_columns = ("A".."G").to_a
    "#{player}, it's your turn. Enter a column (A-G) to make your move:"
    input = gets.chomp.upcase
  
    until input.is_a?(String) && valid_columns.include?(input.upcase)
      "Invalid column. Please enter a column (A-G):"
      input = gets.chomp.upcase
    end
  
    column_index = valid_columns.index(input.upcase)
    @board.make_move(column_index, @player)
  end


  def computer_move
    phrases = ["My turn!"  "GIT-Wrecked", "You will never beat me - HAHAHA", "DRAT!" "I will gIt YOUUU"]
    print phrases[rand(4)]
    move = turn.new(board)
    selected_move = move.make_turn(computer_marker)
    board.make_move(selected_move, computer_marker)
  end

  def display_result
    display_board

    if board.connect4?(player_marker)
      puts "GRUMBLE - You won this time....but you got lucky! - GRUMBLE"
    elsif board.connect4?(computer_marker)
      puts "I won! I told you no one can beat ME! - HAHAHA"
    else
      puts "DRAW - You didn't LOOSE but you didn't win either! I guess I can live with that.... "
    end
  end

  def game_over?
    board.connect4?(player_marker) || board.connect4?(computer_marker) || board.board_full?
  end


  def play
    greeting
    choose_marker
    puts "You are playing as '#{player_marker}'. Make your move by entering the column number (0-6)."
    while true
      system("clear")
      puts print_board
      turn = create_turn
      turn.get_move
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

  