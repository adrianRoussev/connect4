class Turn 

  attr_reader :player, :column_input, :board  

  def initialize(player, board)
    @player = player 
    @column_input = nil
    @board = board
  end 
  
end 