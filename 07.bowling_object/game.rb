# frozen_string_literal: true

require_relative 'frame'
require_relative 'shot'

class Game
  def initialize(score_texts)
    scores = score_texts.split(',')
    score_numbers = []
    scores.each do |score_text|
      if score_text == 'X'
        score_numbers << 10
      else
        score_numbers << score_text.to_i
      end
    end

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
        # 9つできたら、(残りはひとまとめでよい。)
      elsif @frames.size == 10
        frame.size <= 3
        @frames << frame
        frame = []
      end
    end
    p @frames
    # これも考えてみましたが、引き算のところがうまくいかない。
    # p @frames << (score_numbers - @frames.flatten)

  end

  def sum_up
    sum_up = []
    sum_up << calc_total_score << calc_point
    sum_up.flatten.sum
  end

  def calc_total_score
    total_frame_score = []
    @frames.each do |frame|
      total_frame_score << frame.calc_normal_frame
    end
    total_frame_score.sum
  end

  def calc_point
    total_point = []
    @frames.each_with_index do |frame, index|
      break if index == 9

      total_point << if frame.consecutive_strike?
                       frame.calc_consecutive_strike
                     elsif frame.strike?
                       frame.calc_strike
                     elsif frame.spare?
                       frame.calc_spare
                     else
                       0
                     end
    end
    total_point
  end
end
