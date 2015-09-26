class Rook < ActiveRecord::Base

  def move_vertically new_position
    current_coords = ConvertCoordinates.convert_to_numercal_coords position
    new_coords = ConvertCoordinates.convert_to_numercal_coords new_position
    raise "Invalid Move" if new_coords[0] != current_coords[0]
    self.position = new_position
  end

  def move_horizontally new_position
    current_coords = ConvertCoordinates.convert_to_numercal_coords position
    new_coords = ConvertCoordinates.convert_to_numercal_coords new_position
    raise "Invalid Move" if new_coords[1] != current_coords[1]
    self.position = new_position
  end

end
