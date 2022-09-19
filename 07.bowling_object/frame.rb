# frozen_string_literal: true

class Frame
  attr_accessor :frame, :first_shot, :second_shot

  def initialize(frame)
    @frame = frame
    @first_shot = @frame[0]
    @second_shot  = @frame[1]
  end

  def calc_frame
    @frame.sum
  end

  def spare?
    @frame.size == 2 && @first_shot + @second_shot == 10
  end

  def strike?
    @first_shot == 10
  end
end
