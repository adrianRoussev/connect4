require 'pry'
require './board'


RSpec.describe Board do 
  before do
    @board = Board.new
  end
  describe "initialize" do 
    it "exists" do 
      expect(@board).to be_an_instance_of(Board)
    end 

    it "board and markers are initialized as bits" do
      expected = 0b1111110111111011111101111111011111101111110111111

      expect(@board.marker_positions_bit[:X]).to eq(0b0)
      expect(@board.marker_positions_bit[:O]).to eq(0b0)
      expect(@board.full_board).to eq(expected)
    end

    it "has the correct number of rows and columns" do 
      expect(@board.rows).to eq(7)
      expect(@board.columns).to eq (7)
    end 
  end 
end 