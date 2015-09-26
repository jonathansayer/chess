class Pawn < ActiveRecord::Base

  MOVE_LIMIT = 1

  attr_reader:move_limit
  attr_reader:allowed_directions

  def initialize
    @move_limit = MOVE_LIMIT
  end

  def direction
    'forward'
  end
end
