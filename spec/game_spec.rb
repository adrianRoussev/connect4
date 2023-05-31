require 'pry'
require './lib/board'
require './lib/game'
require './lib/turn'

RSpec.describe Game do 
  describe "initialize" do 
    it "exists" do 
      game = Game.new
      expect(game).to be_an_instance_of(Game)
    end 

    it "can create new board instances" do 
      game = Game.new
      expect(game.board).to be_an_instance_of(Board)
    end  

    it "can print a new game message without repeating" do 
      game = Game.new
      expect(game.greeting).to eq("Welcome to Connect 4!")
      expect(game.greeting).to eq(nil)
    end 
    it "turn has an inital turn value of :X" do 
      game = Game.new
      expect(game.turn).to eq(:X)
    end 
  end 

  describe "game flow methods" do 
    it "can create new turns" do 
      game = Game.new
      turn = game.create_turn
      expect(turn).to be_an_instance_of(Turn)
    end
         
    it "can switch turn from :X or :O" do
      game = Game.new
      expect(game.turn).to eq(:X)
      game.switch_turn
      expect(game.turn).to eq(:O)
      game.switch_turn
      expect(game.turn).to eq(:X)
      game.switch_turn
    end

    it "prints an empty board" do
      game = Game.new
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
      #also check the eye test using puts
    end

    it "prints the board with a placed X marker" do
      game = Game.new
      game.board.make_move(0, :X)
      expected_output = <<~BOARD
        A B C D E F G
        . . . . . . .
        . . . . . . .
        . . . . . . .
        . . . . . . .
        . . . . . . .
        X . . . . . .
      BOARD
      expect(game.print_board).to eq(expected_output)
      # also check the eye test using puts
    end

    it "prints the board with multiple moves" do 
      game = Game.new
      game.board.make_move(0, :X)
      game.board.make_move(0, :O)
      game.board.make_move(0, :X)
      game.board.make_move(0, :O)
      game.board.make_move(0, :X)
      game.board.make_move(0, :O)
      game.board.make_move(1, :X)
      game.board.make_move(6, :O)
      expected_output = <<~BOARD
        A B C D E F G
        O . . . . . .
        X . . . . . .
        O . . . . . .
        X . . . . . .
        O . . . . . .
        X X . . . . O
      BOARD
      expect(game.print_board).to eq(expected_output)
    end
  end 
  describe "play again" do
     let(:game) { Game.new } 
    it "can create a new board and start new game" do 
      allow(game).to receive(:gets).and_return("Y")
      original = game.instance_variable_get(:@board)
      expect(game).to receive(:play)
      game.play_again
      expect(game.instance_variable_get(:@board)).not_to be(original)
    end 

    it "only accepts Y and N as valid inputs" do 
      allow(game).to receive(:gets).and_return("3", "N")
      expect { game.play_again }.to output(/Invalid input. Please enter Y for yes or N for no./).to_stdout
    end
  end
end 