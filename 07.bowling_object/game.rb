# frozen_string_literal: true

require_relative 'frame'

class Game
  attr_accessor :frames

  def initialize(score_texts)
    score_numbers = make_score_numbers(score_texts)
    array_for_frames = make_array_for_frames(score_numbers)
    @frames = []
    array_for_frames.each do |array_for_frame|
      @frames << Frame.new(array_for_frame)
    end
    # p @frames
  end

  def calc_total_score
    total_score = []
    # イテレーターはframeでも同じ結果となる。その際はFrameクラスを呼ぶメソッドのレシーバーもframeとする。
    @frames.each do |f|
      # total_score <<
      # スペアだったら
      p f
      if f.spare?
        p 'スペア'
      # ストライクだったら
      # ストライクの時の計算メソッド
      else
        p 'スペアでもストライクでもない'
      end
    end
    total_score
  end

  def make_score_numbers(score_texts)
    score_texts.split(',').map { |score_text| score_text == 'X' ? 10 : score_text.to_i }
  end

  def make_array_for_frames(score_numbers)
    array_for_frames = []
    frame = []
    score_numbers.each do |score_number|
      frame << score_number
      # p "frame:#{frame}"
      if array_for_frames.size < 9 && frame.size == 2
        array_for_frames << frame
        frame = []
      elsif array_for_frames.size < 9 && score_number == 10
        frame.size == 1
        array_for_frames << frame
        frame = []
      elsif array_for_frames.size == 9
        frame = []
        frame << score_number
        frame.size == 3
        array_for_frames << frame
      end
    end
    p array_for_frames
  end
end
