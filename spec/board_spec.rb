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

    it "board is the correct size" do 
      bit_str = @board.full_board.to_s(2)
      expect(bit_str.chars.count).to eq(49)
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

    it "has the correct bit values for the current and final position arrays" do
      current = [0, 7, 14, 21, 28, 35, 42]
      final =  [5, 12, 19, 26, 33, 40, 47]
      expect(@board.current_position_ar).to eq(current)
      expect(@board.final_position_ar).to eq(final)
    end 

    xit "accomodates for extra row at the top which is not part of the playing board" do 
      bit_str = @board.full_board.to_s(2)
      bit_map = bit_str.chars.map {|char| [char]}
      expect(bit_map[6].join.reverse).to eq ("0")
      expect(bit_map[13].join).to eq ("0")
      expect(bit_map[20].join).to eq ("0")
      expect(bit_map[27].join).to eq ("0")
      expect(bit_map[34].join).to eq ("0")
      expect(bit_map[41].join).to eq ("0")
      expect(bit_map[48].join).to eq ("0")
    end 
  end 
end 