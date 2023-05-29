require 'pry'
require './board'
require './lib/game'

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
    it "has an inital turn value of :X" do 
      game = Game.new
      expect(game.turn).to eq(:X)
    end 
  end 

  describe "game flow methods" do 
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
      #also check the eye test using puts game.print_board
    end

    # it "correctly prints placed pieces onto the board" do 
    # obv need to incorporate the take turn methods before checking this
    # end 

    # it "can alternate turns" do 
    # obv need to incorporate the take turn methods before checking this
    # end 
  end 

  # describe "win conditions" do 
  #   win conditions checks will go here 
  # end 


end 