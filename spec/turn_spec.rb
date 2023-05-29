require 'pry'
require './board'
require './lib/game'
require './lib/turn'

RSpec.describe Turn do 
  describe "initialize" do 
    it "exists" do 
      game = Game.new
      turn = game.create_turn
      expect(turn).to be_an_instance_of(Turn)
    end
    
    it "correctly recieves player info from game" do
      game = Game.new
      turn = game.create_turn
      game.switch_turn
      turn2 = game.create_turn
      expect(turn.player).to eq(:X)
      expect(turn2.player).to eq(:O)
    end
    
    
    it "has default value of nil for column input" do 
      game = Game.new
      turn = game.create_turn
      expect(turn.column_input).to be nil 
    end 
  end

  describe "get_move method" do 
    it 'passes input from the player to the board' do
      game = Game.new
      turn = game.create_turn
      input = "A"
      expect(turn.get_move_with_input(input)).to eq(1) 
      # +1, to accomodate the make_move return value in board class. 
      input = "B"
      expect(turn.get_move_with_input(input)).to eq(8) 
      input = "C"
      expect(turn.get_move_with_input(input)).to eq(15) 
    end

    it "only accepts single entries of A-G as valid inputs" do 
      game = Game.new
      turn = game.create_turn
      input = 4
      expect(turn.get_move_with_input(input)).to eq("Invalid column.")
      input = "p"
      expect(turn.get_move_with_input(input)).to eq("Invalid column.")
      input = ["A", "B"]
      expect(turn.get_move_with_input(input)).to eq("Invalid column.")
    end
  
    it "can accept lowercase and uppercase entries of valid letters" do 
      game = Game.new
      turn = game.create_turn
      input = "A"
      expect(turn.get_move_with_input(input)).to eq(1) 
      input = "b"
      expect(turn.get_move_with_input(input)).to eq(8) 
    end  
  end 
  
end  