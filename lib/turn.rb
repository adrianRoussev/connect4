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
