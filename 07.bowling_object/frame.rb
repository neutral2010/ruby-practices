# frozen_string_literal: true

class Frame
  attr_accessor :frame

  def initialize(frame)
    @frame = frame
  end

  def calc_frame
    @frame.sum
  end

  def spare?
    @frame.sum == 10 && @frame.size == 2
  end

  def strike?
    @frame[0] == 10
  end
end
