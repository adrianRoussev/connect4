

require './lib/game.rb'

def main
  game = Game.new
  game.play
  game.show_high_scores
end

main
