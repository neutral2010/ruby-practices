# frozen_string_literal: true

require_relative 'frame'

class Game
  attr_accessor :frames

  def initialize(score_texts)
    score_numbers = make_score_numbers(score_texts)
    make_frames(score_numbers)
    @frames.each do |frame|
      p Frame.new(frame)
    end
  end

  def calc_total_score
    total_score = []
    # @frames.each_with_index do |f, i|
    @frames.each_with_index do |frame, i|
      total_score <<
        # スペアだったら
        # if f.sum == 10 && f.size == 2
        if frame.spare?
          # スペアの時の計算メソッド
          frame.calc_frame + @frames[i + 1][0]
          # f.sum + @frames[i + 1][0]
          # ストライクだったら
          # ストライクの時の計算メソッド
        else
          frame.calc_frame
          # f.sum
        end
    end
    total_score
  end

  def make_score_numbers(score_texts)
    score_texts.split(',').map { |score_text| score_text == 'X' ? 10 : score_text.to_i}
  end

  def make_frames(score_numbers)
    @frames = []
    frame = []
    score_numbers.each do |score_number|
      frame << score_number
      # p "frame:#{frame}"
      if @frames.size < 9 && frame.size == 2
        @frames << frame
        frame = []
      elsif frames.size < 9 && score_number == 10
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
    p @frames
  end
end
