# frozen_string_literal: true

require_relative 'game'

def score_numbers_for_frame(score_texts)
  scores = score_texts.split(',')
  score_numbers = []
  scores.each do |score_text|
    if score_text == 'X'
      score_numbers << 10
    else
      score_numbers << score_text.to_i
    end
  end
  score_numbers
end

if __FILE__ == $PROGRAM_NAME
  score_texts = ARGV[0]
  game = Game.new(score_texts)
  p game.sum_up
end
