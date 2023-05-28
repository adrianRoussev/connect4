class Turn 

  attr_reader :player, :column_input, :board  

  def initialize(player, board)
    @player = player 
    @column_input = nil
    @board = board
  end 



  def get_move
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

  def get_move_with_input(input)
    #This is a method for test purposes, testing gets.chomp was quite difficult.
    #I am thinking we can use this for the CPU turn though, with the computer logic method spitting out whatever "input" will be?
    valid_columns = ('A'..'G').to_a
  
    until input.is_a?(String) && valid_columns.include?(input.upcase)
      return "Invalid column."
    end
    
    column_index = valid_columns.index(input.upcase)
    @board.make_move(column_index, @player) 
  end    
end 