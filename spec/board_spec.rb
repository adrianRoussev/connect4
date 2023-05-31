require 'pry'
require './lib/board'


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
      expect(bit_str.chars.count).to eq(48)
      #48 since we don't need the final 0 
    end 

    it "board and markers are initialized as bits" do
      expected = 0b0111111011111101111110111111011111101111110111111

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

    it "accomodates for extra row at the top which is not part of the playing board" do 
      bit_str = @board.full_board.to_s(2)
      bit_map = bit_str.chars.map {|char| [char]}
      expect(bit_map[6].join).to eq ("0")
      expect(bit_map[13].join).to eq ("0")
      expect(bit_map[20].join).to eq ("0")
      expect(bit_map[27].join).to eq ("0")
      expect(bit_map[34].join).to eq ("0")
      expect(bit_map[41].join).to eq ("0")
    end 
  end 

  describe "instance methods" do
    it "make_move places markers in the correct column" do
      @board.make_move(0, :X)
      @board.make_move(0, :O)
      expect(@board.marker_positions_bit[:X]).to eq(0b001)
      expect(@board.marker_positions_bit[:O]).to eq(0b010)
    end

    it "free_spaces_count counts number of free spaces" do 
      expect(@board.free_spaces_count).to eq(42)
      6.times {@board.make_move(0, :X)}
      expect(@board.free_spaces_count).to eq(36)
    end 

    it "make_move can only add 6 markers to one column" do 
      7.times {@board.make_move(0, :X)}
      expect(@board.marker_positions_bit[:X]).to eq(0b111111)
      bit_str = (@board.marker_positions_bit[:X]).to_s(2)
      expect(bit_str.chars.count).to eq(6)
    end 

    it "board_full returns correct value" do 
      expect(@board.board_full?).to be false 
      6.times {@board.make_move(0, :X)}
      6.times {@board.make_move(1, :X)}
      6.times {@board.make_move(2, :X)}
      6.times {@board.make_move(3, :X)}
      6.times {@board.make_move(4, :X)}
      6.times {@board.make_move(5, :X)}
      5.times {@board.make_move(6, :X)}
      @board.free_spaces_count
      expect(@board.board_full?).to be false 

      @board.make_move(6, :X)
      @board.free_spaces_count
      expect(@board.board_full?).to be true  
    end 
  end

  describe "win conditions" do 
    it "can check for connect 4 vertically" do 
      @board.make_move(0, :X)
      @board.make_move(0, :X)
      @board.make_move(0, :X)
      @board.make_move(0, :X)
      expect(@board.connect4?(:X)).to be true 
    end 

    it "can check for connect 4 horizontally" do 
      @board.make_move(0, :X)
      @board.make_move(1, :X)
      @board.make_move(2, :X)
      @board.make_move(3, :X)
      expect(@board.connect4?(:X)).to be true 
    end 

    it "can check for connect 4 diagonally up" do 
      @board.make_move(0, :X)

      @board.make_move(1, :O)
      @board.make_move(1, :X)

      @board.make_move(2, :O)
      @board.make_move(2, :O)
      @board.make_move(2, :X)

      @board.make_move(3, :O)
      @board.make_move(3, :O)
      @board.make_move(3, :O)
      @board.make_move(3, :X)

      expect(@board.connect4?(:X)).to be true 
    end 

    it "can check for connect 4 diagonally down" do 
      @board.make_move(0, :O)
      @board.make_move(0, :O)
      @board.make_move(0, :O)
      @board.make_move(0, :X)

      @board.make_move(1, :O)
      @board.make_move(1, :O)
      @board.make_move(1, :X)

      @board.make_move(2, :O)
      @board.make_move(2, :X)

      @board.make_move(3, :X)

      expect(@board.connect4?(:X)).to be true 
    end 

  end 
end 