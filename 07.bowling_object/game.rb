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
    # スコアナンバーズを先頭から2個ずつ10個の配列に分ける。
    # もし、10の場合は1つでよい。9つできたら、残りはひとまとめでよい。
    @frames = []
    frame = []
    score_numbers.each do |score_number|
      frame << score_number
      p "frame:#{frame}"
      if frame.size == 2
        @frames << frame
        frame = []
      end
      p @frames
    end
    # frame_marks = score_numbers.each_slice(2).to_a
    # frame_marks.each_index do |index|
    #   @frames << Frame.new(frame_marks[index][0], frame_marks[index][1], frame_marks, index)
    # end
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
