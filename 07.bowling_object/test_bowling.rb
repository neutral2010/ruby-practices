# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'main'

class BowlingTest < Minitest::Test
  def main
    assert_equal 139, Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5').calc_total_score
    assert_equal 164, Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X').calc_total_score
    assert_equal 107, Game.new('0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4').calc_total_score
    assert_equal 134, Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0').calc_total_score
    assert_equal 144, Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8').calc_total_score
    assert_equal 300, Game.new('X,X,X,X,X,X,X,X,X,X,X,X').calc_total_score
  end
end
