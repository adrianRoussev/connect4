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
end 