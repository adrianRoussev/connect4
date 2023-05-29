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


  def print_board
    output = ""
    output += ("A".."G").to_a.join(" ") + "\n"

    6.times do
      row_output = ["."] * @board.columns
      output += row_output.join(" ") + "\n"
    end

    output

    # will update to include marker locations for placed pieces once those methods within turn are up and running
  end
end 