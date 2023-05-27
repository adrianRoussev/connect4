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
  
end 

end 