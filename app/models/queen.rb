class Queen < ActiveRecord::Base

  def move_to new_position
    self.position = new_position
  end
end
