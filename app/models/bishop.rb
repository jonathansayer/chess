class Bishop < ActiveRecord::Base
  belongs_to :board

  def move_to new_position
    raise 'Invalid Move' unless diagonal_move? new_position
    self.position = new_position
  end

  private

  def diagonal_move? new_position
    current_coords = ConvertCoordinates.convert_to_numercal_coords self.position
    new_coords = ConvertCoordinates.convert_to_numercal_coords new_position
    return ((current_coords[0] - new_coords[0]).abs == (current_coords[1] - new_coords[1]).abs)
  end

end
