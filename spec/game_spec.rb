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
    xit "can print board" do
      game = Game.new
  
      expected_output = 
      "A B C D E F G\n" \
      ".......\n" \
      ".......\n" \
      ".......\n" \
      ".......\n" \
      ".......\n" \
      ".......\n"

      rows = expected_output.split("\n")
  
      expect(expected_output.length).to eq(48)
      expect(expected_output[0].split.length).to eq(7)
      expect(expected_output[1].split.length).to eq(7)
      expect(rows[0].split.length).to eq(7)
      expect(rows[1].split.length).to eq(7)
      # ^ eq(7) to include the A-G column identifiers
      expect(game.printboard).to eq(expected_output)
      #use pry to verify the "eye test" as well
    end 

    # it "correctly prints placed pieces onto the board" do 
    # obv need to incorporate the take turn methods before checking this
    # end 

    # it "can keep track of turns" do 
    # obv need to incorporate the take turn methods before checking this
    # end 
  end 
end 