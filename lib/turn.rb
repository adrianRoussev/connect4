class Turn
    attr_reader :board

    def initialize(board)
        @board = board
    end

    def make_turn(marker)
        best_move = predict_best_move(marker)
        board.make_move(best_move, marker)
    end