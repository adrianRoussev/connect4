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
    xit 'requests input from the player' do
      game = Game.new
      turn = game.create_turn
      input = 'A'
      expect(turn.get_move_with_input(input)).to eq(0) 
    end
    # This is the test that is perplexing me at the moment.
    # A = 1 instead of 0 
    # B = 8 instead of 7
    # C = 15 instead of 14

    # altering column_index = valid_columns.index(input) = or - 1 
    # changes the value by 7. 

  
    it "only accepts single entries of A-G as valid inputs" do 
      game = Game.new
      turn = game.create_turn
      input = 4
      expect(turn.get_move_with_input(input)).to eq("Invalid column.")
      input = "p"
      expect(turn.get_move_with_input(input)).to eq("Invalid column.")
      input = ['A', "B"]
      expect(turn.get_move_with_input(input)).to eq("Invalid column.")
    end
  
    xit "can accept lowercase and uppercase entries of valid letters" do 

      game = Game.new
      turn = game.create_turn
      input = 'A'
      expect(turn.get_move_with_input(input)).to eq(0) 
      input = 'a'
      expect(turn.get_move_with_input(input)).to eq(0) 
    end 
    #this will work once the other test is sorted. 

    xit "correctly sends retrieved information to the board via make_move" do 
    end 
  end 
  
end  