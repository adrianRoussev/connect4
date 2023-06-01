class Game

  attr_reader :board, :turn

  def initialize
    @board = Board.new
    @turn = :X
    @start = true 
    @board = Board.new
    @player_marker = nil
    @computer_marker = nil
    @scores = []
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


  def computer_move
    phrases = ["My turn!"  "GIT-Wrecked", "You will never beat me - HAHAHA", "DRAT!" "I will gIt YOUUU"]
    print phrases[rand(4)]
    move = turn.new(board)
    selected_move = move.make_turn(computer_marker)
    board.make_move(selected_move, computer_marker)
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
end 