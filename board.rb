#This is the board layout. Each number represents a position on the board, 
#which can be converted to a bit pattern. @full_board in the initialize method
#represents the board when completely filled For this to work nicely we need it 
#to be a 7 by 7 square. If you look at the full board bit pattern you will see 
#0 at every 7th number. That represents the top row which will never 
#be filled since the game has 6 rows.  

# 6 13 20 27 34 41 48
# 5 12 19 26 33 40 47
# 4 11 18 25 32 39 46
# 3 10 17 24 31 38 45
# 2  9 16 23 30 37 44
# 1  8 15 22 29 36 43
# 0  7 14 21 28 35 42

class Board
    attr_reader :marker_positions_bit, :current_position_ar,:final_position_ar, :rows, :columns

    def initialize
    @marker_positions_bit= {:X => 0b0, :O => 0b0}   #0b is added at the begining of the bit to indicate 
                                                    #that it is a bit and not a decimal (regular) number
    @full_board = 0b1111110111111011111101111111011111101111110111111
    @columns = 7
    @rows = 7
    @horizontal = @columns
    @verticle = 1
    @diagonal_up_right= @horizontal + @verticle
    @diagonal_down_left = @horizontal - @verticle
    @max_filled = @columns * @rows - 1 
    @current_position_ar = [0, 7, 14, 21, 28, 35, 42]
    @final_position_ar = [5, 12, 19, 26, 33, 40, 47]

    end 

    #line 44 uses a ruby bitwise function called OR. It compares two bit patterns 
    #of equal length and at each position assigns either 1 or 0 creating a new 
    #bit pattern.It assigns 0 if both bits are 0, and if either contain 1 in that
    #possition, 1 is assigned.This allows us to add the new bit pattern of the current 
    #move to the existing moves. Later we will use some of the others like XAND to compare 
    #:X and :O to winning combinations.
    
    def make_move(column, marker)
        position = @current_position_ar.fetch(column)
        @marker_positions_bit[marker] = @marker_positions_bit[marker] | (2**position)
    
        if  position == @final_position_ar.fetch(column)  
            nil 
        else
            @current_position_ar[column] = position +1
        end
    
    end
end 

#SOME RESOURCES: #the first link gives a very simple and easy to follow example of how this 
            #can be used for tic tac toe, (basically the same game on smaller scale)
#https://codepen.io/labiej/post/using-bit-logic-to-keep-track-of-a-tic-tac-toe-game
#https://en.wikipedia.org/wiki/Bitwise_operation#XOR