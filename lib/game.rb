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

    def print_board
      output = ""
      output += ("A".."G").to_a.join(" ") + "\n"
  
      6.times do
        row_output = ["."] * @board.columns
        output += row_output.join(" ") + "\n"
      end
  
      output
    end

end 