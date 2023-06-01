require 'pry'
require './lib/board'
require './lib/game'
require './lib/turn'

require './lib/game'

RSpec.describe Game do
  let(:game) { Game.new }

  describe "#greeting" do
    it "prints the welcome message only once" do
      expect { game.greeting }.to output("Welcome to Connect 4!\n").to_stdout
      expect { game.greeting }.not_to output.to_stdout
    end
  end

  describe "#create_turn" do
    it "creates a new instance of Turn" do
      turn = game.create_turn
      expect(turn).to be_a(Turn)
      expect(turn.board).to eq(game.board)
    end
  end

  describe "#print_board" do
    it "returns a formatted string representing the current board" do
      expected_output = <<~BOARD
        A B C D E F G
        . . . . . . .
        . . . . . . .
        . . . . . . .
        . . . . . . .
        . . . . . . .
        . . . . . . .
      BOARD
      expect(game.print_board).to eq(expected_output)
    end
  end

  describe "#player_move" do
    it "prompts the player for a move and updates the board" do
      allow(game).to receive(:gets).and_return("A\n")
      expect { game.player_move }.to output("X, it's your turn.\n").to_stdout
      expect(game.board.current_position_ar).to eq([1, 0, 0, 0, 0, 0, 0])
    end
  end

  describe "#computer_move" do
    it "makes a move for the computer and updates the board" do
      allow(game.turn).to receive(:predict_best_move).and_return(3)
      game.computer_move
      expect(game.board.current_position_ar).to eq([0, 0, 0, 1, 0, 0, 0])
    end
  end

  describe "#display_result" do
    it "displays the current board and the game result" do
      allow(game).to receive(:print_board).and_return("Sample Board\n")
      game.board.make_move(0, :X)
      expect { game.display_result }.to output("Sample Board\n").to_stdout
      expect { game.display_result }.to output("Congratulations! You won!\n").to_stdout
    end
  end

  describe "#game_over?" do
    it "returns true if the game is over" do
      game.board.make_move(0, :X)
      game.board.make_move(1, :X)
      game.board.make_move(2, :X)
      game.board.make_move(3, :X)
      expect(game.game_over?).to be true
    end

    it "returns false if the game is not over" do
      expect(game.game_over?).to be false
    end
  end

  describe "#round" do
    it "executes a round of the game" do
      allow(game).to receive(:greeting)
      allow(game).to receive(:system)
      allow(game).to receive(:puts)
      allow(game).to receive(:print_board)
      allow(game).to receive(:player_turn)
      allow(game).to receive(:computer_turn)
      allow(game).to receive(:display_result)
      allow(game).to receive(:update_scores)
      allow(game).to receive(:show_high_scores)
      allow(game).to receive(:play_again?).and_return(false)

      expect(game).to receive(:greeting)
      expect(game).to receive(:print_board).twice
      expect(game).to receive(:player_turn)
      expect(game).to receive(:display_result)
      expect(game).to receive(:update_scores)
      expect(game).to receive(:show_high_scores)
      expect(game).to receive(:play_again?).and_return(false)

      game.round
    end
  end

  describe "#play" do
    it "plays the game until the player chooses not to continue" do
      allow(game).to receive(:round)
      allow(game).to receive(:display_result)
      allow(game).to receive(:player_continues?).and_return(true, true, false)

      expect(game).to receive(:round).twice
      expect(game).to receive(:display_result)

      game.play
    end
  end

  describe "#play_again?" do
    it "returns true if the player chooses to play again" do
      allow(game).to receive(:gets).and_return("Y\n")
      expect { game.play_again? }.to output("Would you like to play again? (Y/N)\n").to_stdout
      expect(game.play_again?).to be true
    end

    it "returns false if the player chooses not to play again" do
      allow(game).to receive(:gets).and_return("N\n")
      expect { game.play_again? }.to output("Would you like to play again? (Y/N)\n").to_stdout
      expect(game.play_again?).to be false
    end
  end

  describe "#reset_game" do
    it "resets the game by creating a new board" do
      expect { game.reset_game }.to output("Starting a new game!\n").to_stdout
      expect(game.board).to be_a(Board)
    end
  end

  describe "#update_scores" do
    it "adds a winner to the scores list" do
      game.board.make_move(0, :X)
      expect { game.update_scores }.to change { game.scores.length }.by(1)
      expect(game.scores.last[:winner]).to eq('Player')
      expect(game.scores.last[:timestamp]).to be_a(Time)
    end
  end

  describe "#show_high_scores" do
    it "displays the high scores" do
      game.scores = [
        { winner: 'Player', timestamp: Time.now },
        { winner: 'Computer', timestamp: Time.now },
      ]
      expect { game.show_high_scores }.to output("High Scores:\n1. Player - #{game.scores.first[:timestamp]}\n2. Computer - #{game.scores.last[:timestamp]}\n\n").to_stdout
    end

    it "displays a message if there are no high scores" do
      expect { game.show_high_scores }.to output("High Scores:\nNo scores recorded yet.\n").to_stdout
    end
  end
end
