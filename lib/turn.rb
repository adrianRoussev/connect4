class Turn 

  attr_reader :player, :column_input, :board  

  def initialize(player, board)
    @player = player 
    @column_input = 0
    @board = board
  end 



  def get_move
    valid_columns = ('A'..'G').to_a
    puts "#{player}, it's your turn. Enter a column (A-G) to make your move:"
    input = gets.chomp
  
    until valid_columns.include?(input)
      puts "Invalid column. Please enter a column (A-G):"
      input = gets.chomp.upcase
    end
  
    column_index = valid_columns.index(input)
    @board.make_move(column_index, player)
  end

  def get_move_with_input(input)
    # This is just for testing purposes since .gets was quite problematic to test.
    # This will be identical to the method above aside from how input is enterted.
    # This will be commented out once tests are passed so the real method can be used in game. 
    valid_columns = ('A'..'G').to_a
    puts "#{@player}, it's your turn. Enter a column (A-G) to make your move:"
    
    until valid_columns.include?(input)
      return "Invalid column."
    end
    
    column_index = valid_columns.index(input)
    @board.make_move(column_index, @player) 
  end
  
    
end 