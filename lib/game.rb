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
  
end 