require 'pry'
require './board'
require './lib/game'
require './lib/turn'

RSpec.describe Turn do 
  describe "initialize" do 
    it "exists" do 
      turn = Turn.new("turn")
      expect(turn).to be_an_instance_of(Turn)
    end 
    it "can assign turn as either :X or :O" do
      turn = Turn.new(:X)
      turn2 = Turn.new(:O)
      expect(turn.player).to eq(:X)
      expect(turn2.player).to eq(:O)
    end 
    it "has default value of nil for column input" do 
      turn = Turn.new("turn")
      expect(turn.column_input).to be nil 
    end 
  end

  describe "get_move method" do 
    it 'requests input from the player' do
      turn = Turn.new(:X)

      expect(turn.get_move).to output("X, it's your turn. Enter a column (A-G) to make your move:\n").to_stdout
    end
  
    it "only accepts A-G as valid inputs" do 
    end
  
    it "can accept lowercase and uppercase entries of valid letters" do 
    end 
  
    it "correctly sends retrieved information to the board via make_move" do 
    end 
  end 
  
end  