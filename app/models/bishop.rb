class Bishop < ActiveRecord::Base

  def move_to new_position
    raise 'Invalid Move' if invalid_move? new_position
    self.position = new_position
  end

  private

  def invalid_move? new_position
    current_coords = ConvertCoordinates.convert_to_numercal_coords self.position
    new_coords = ConvertCoordinates.convert_to_numercal_coords new_position
    if ((current_coords[0] - new_coords[0]).abs != (current_coords[1] - new_coords[1]).abs)
      return true
    else
      return false
    end
  end

end
