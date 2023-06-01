

require './lib/board'


class Turn 
    attr_reader :player, :column_input, :board  

def initialize( board)

    @board = board
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
    
    def make_turn(marker)
        column = predict_best_move(marker)
        column
        board.make_move(column, marker)
       
      end
      

      def predict_best_move(marker)
            available_moves = (0..6).to_a.select { |column| board.valid_move?(column) }
            best_move = available_moves.sample if available_moves.any?
            best_move
          end
        end
    #     available_moves = (0..6).to_a.select { |column| board.valid_move?(column) }
      
    #     best_move = nil
    #     best_score = -Float::INFINITY
      
    #     available_moves.each do |move|
    #       temp_board = board.dup
    #       temp_board.make_move(move, marker)
    #       score = evaluate_move(temp_board, marker, 4, -Float::INFINITY, Float::INFINITY)
      
    #       if score > best_score
    #         best_score = score
    #         best_move = move
    #       end
    #     end
      
    #     if best_move.nil?
    #       best_move = available_moves.sample if available_moves.any?
    #     end
      
    #     best_move
    #   end
    #   def evaluate_move(board, marker, depth, alpha, beta)
    #     if board.connect4?(marker)
    #       return marker == :X ? 1 : -1
    #     elsif board.board_full? || depth.zero?
    #       return nil
    #     end
      
    #     opponent_marker = marker == :X ? :O : :X
    #     available_moves = (0..6).to_a.select { |column| board.valid_move?(column) }
      
    #     if marker == :X
    #       available_moves.each do |move|
    #         temp_board = board.dup
    #         temp_board.make_move(move, marker)
      
    #         column_index = move
    #         column_depth = temp_board.final_position_ar[column_index] - temp_board.current_position_ar[column_index]
      
    #         alpha = [alpha, evaluate_move(temp_board, opponent_marker, column_depth, alpha, beta)].max
    #         break if alpha >= beta
    #       end
    #       alpha
    #     else
    #       available_moves.each do |move|
    #         temp_board = board.dup
    #         temp_board.make_move(move, marker)
      
    #         column_index = move
    #         column_depth = temp_board.final_position_ar[column_index] - temp_board.current_position_ar[column_index]
      
    #         beta = [beta, evaluate_move(temp_board, opponent_marker, column_depth, alpha, beta)].min
    #         break if beta <= alpha
    #       end
    #       beta
    #     end
    #   end
    # end 