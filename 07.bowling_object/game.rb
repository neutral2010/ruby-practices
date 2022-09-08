# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(score_texts)
    score_numbers = []
    score_texts.split(',').each do |score_text|
      score_numbers << if score_text == 'X'
                         10
                       else
                         score_text.to_i
                       end
    end
    make_frames(score_numbers)
    @frames.each do |frame|
      p Frame.new(frame)
    end
  end

  def make_frames(score_numbers)
    @frames = []
    frame = []
    score_numbers.each do |score_number|
      frame << score_number
      p "frame:#{frame}"
      if @frames.size < 9 && frame.size == 2
        @frames << frame
        frame = []
      elsif @frames.size < 9 && score_number == 10
        frame.size == 1
        @frames << frame
        frame = []
      elsif @frames.size == 9
        frame = []
        frame << score_number
        frame.size == 3
        @frames << frame
      end
    end
  end
end
