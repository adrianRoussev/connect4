class Game

  attr_reader :board

  def initialize
    @board = Board.new
    @start = true 
  end

    def greeting 
      @start ? (@start = false; "Welcome to Connect 4!") : nil
    end  
end 