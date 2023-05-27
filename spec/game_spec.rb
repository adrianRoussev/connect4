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
  end 

  describe "game flow methods" do 
    it "can print board" do 
    end 

    it "can keep track of turn" do 
    end 
  end 
end 