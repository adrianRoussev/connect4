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
    attr_reader :marker_positions_bit, :current_position_ar,:final_position_ar

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

        def free_spaces_count
            @total_positions = @marker_positions_bit[:X] |     @marker_positions_bit[:O]
            @empty_positions = @total_positions ^ @full_board
            @empty_positions.to_s(2).count('1')
        end


        def board_full?
        
            @empty_positions == 0
        end
    
    
        def connect4?(marker)
            marker_positions = @marker_positions_bit[marker]
            bit_leading_0s_removed = marker_positions.to_s(2).sub(/0+$/, '').to_i
            direction_shift_ar = [@horizontal, @vertical, @diagonal_up_right, @diagonal_down_left]
        
            direction_shift_ar.any? do |direction_shift|
                @current_position_ar.each do |position|
                bit_shift = bit_leading_0s_removed >> position
                array = []
        
                i = 1
                loop do
                bit_shifted = bit_shift >> (i - 1)
                marker_shift_1 = (bit_shift >> i) << 1
        
                    if marker_shift_1 == 0 && bit_shifted != 0
                        array << 1
                    elsif marker_shift_1 != 0 && bit_shifted % marker_shift_1 > 0
                        array << 1
                    else
                        array.clear
                    end
        
                    if direction_shift != 0
                        i += direction_shift
                    else
                        break
                    end
        
                    if array.count == 4 || ((bit_shift >> i) << 1) == 0
                        break
                    end
                    end
        
                if array.count == 4
                    return true
                end
            end
        end
    
            false
    end
        
end



#SOME RESOURCES: #the first link gives a very simple and easy to follow example of how this 
            #can be used for tic tac toe, (basically the same game on smaller scale)
#https://codepen.io/labiej/post/using-bit-logic-to-keep-track-of-a-tic-tac-toe-game
#https://en.wikipedia.org/wiki/Bitwise_operation#XOR