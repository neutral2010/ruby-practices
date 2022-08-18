# frozen_string_literal: true

require_relative 'frame'
require_relative 'shot'

class Game
  def initialize(score_numbers)
    @frames = [] # 10frameを作る
    frame_marks = score_numbers.each_slice(2).to_a
    frame_marks.each_index do |index|
      @frames << Frame.new(frame_marks[index][0], frame_marks[index][1], frame_marks, index)
    end
    # pp @frames
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
                       # total_point << frame.frame_marks[index + 1][0] << frame.frame_marks[index + 2][0]
                       frame.calc_consecutive_strike
                     elsif frame.strike?
                       # total_point << frame.frame_marks[index + 1][0] << frame.frame_marks[index + 1][1]
                       frame.calc_strike
                     elsif frame.spare?
                       # total_point << frame.frame_marks[index + 1][0]
                       frame.calc_spare
                     else
                       0
                     end
    end
    total_point
  end
end
