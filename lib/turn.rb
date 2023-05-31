class Turn
    attr_reader :board

    def initialize(board)
        @board = board
    end

    def make_turn(marker)
        best_move = predict_best_move(marker)
        board.make_move(best_move, marker)
    end

    def predict_best_move(marker)
        available_moves = (0..6).to_a.select {|column| board.valid_move?(column)}
        best_move = nil
        best_score = -Float::INFINITY

        available_moves.each do |move|
            temp_board = board.dup
            temp_board.make_move(move, marker)
            score = evaluate_move(temp_board, marker, 4, -Float::INFINITY, Float::INFINITY)
        
            if score > best_score
                best_score = score
                best_move = move
            end
        end

        best_move
    end

    def evaluate_move(board, marker, depth, alpha, beta)
        if board.connect4?(marker)
            marker == :X ? 1 : -1
        elsif board.board_full? || depth.zero?
            0
        end

        opponent_marker = marker == :X ? :O : :X
        available_moves = (0..6).to_a.select { |column| board.valid_move?(column) }
        if marker == :X
            available_moves.each do |move|
                temp_board = board.dup
                temp_board.make_move(move, marker)
                alpha = [alpha, evaluate_move(temp_board, opponent_marker, depth - 1, alpha, beta)].max
                break if alpha >= beta
            end
            alpha
        else
            available_moves.each do |move|
                temp_board = board.dup
                temp_board.make_move(move, marker)
                beta = [beta, evaluate_move(temp_board, opponent_marker, depth - 1, alpha, beta)].min
                break if beta <= alpha
            end
            beta
        end
    end
end
