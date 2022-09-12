# frozen_string_literal: true

require_relative 'game'
require_relative 'frame'

if __FILE__ == $PROGRAM_NAME
  score_texts = ARGV[0]
  game = Game.new(score_texts)
  p game.calc_total_score
end
