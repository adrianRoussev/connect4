require 'pry'
require './board'
require './lib/game'
require './lib/turn'

RSpec.describe Turn do 
  describe "initialize" do 
    it "exists"
    turn = Turn.new
    expect(turn).to be_an_instance_of(Turn)
  end 


end 