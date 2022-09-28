# frozen_string_literal: true

require_relative 'frame'

class Game
  attr_accessor :frames

  def initialize(score_texts)
    score_numbers = make_score_numbers(score_texts)
    @array_for_frames = make_array_for_frames(score_numbers)
    @frames = @array_for_frames.map { |array_for_frame| Frame.new(array_for_frame) }
  end

  def calc_total_score
    total_score = []
    @frames.each_with_index do |frame, index|
      total_score << if frame.spare?
                       calc_spare(frame, index)
                     elsif frame.strike? && index <= 8
                       calc_strike(frame, index)
                     else
                       frame.total_fallen_pins
                     end
    end
    total_score.sum
  end

  def make_score_numbers(score_texts)
    score_texts.split(',').map { |score_text| score_text == 'X' ? 10 : score_text.to_i }
  end

  def make_array_for_frames(score_numbers)
    array_for_frames = []
    frame = []
    score_numbers.each do |score_number|
      frame << score_number
      if ((array_for_frames.size < 9) && (frame.size == 2)) || # 9投目まででスペア
         (array_for_frames.size < 9) && (score_number == 10) # 9投目まででストライク
        array_for_frames << frame
        frame = []
      elsif array_for_frames.size == 9 # 10投目
        frame = []
        frame << score_number
        array_for_frames << frame
      end
    end
    p array_for_frames
  end

  def calc_spare(frame, index)
    frame.total_fallen_pins + @frames[index + 1].first_shot
  end

  def calc_strike(frame, index)
    @frames[index + 1].first_shot +
      if @frames[index + 1].second_shot.nil?
        @frames[index + 2].first_shot
      else
        @frames[index + 1].second_shot
      end + frame.total_fallen_pins
  end
end
