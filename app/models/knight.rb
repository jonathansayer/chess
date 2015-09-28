class Knight < ActiveRecord::Base
  belongs_to :board

  def move_to new_position
    raise 'Invalid Move' unless valid_move? new_position
    self.position = new_position
  end

  private

  def valid_move? new_position
    (move_two_horizontally? new_position and move_one_vertically? new_position) or (move_two_vertically? new_position and move_one_horizontally? new_position)
  end

  def move_two_horizontally? new_position
    current_coords = ConvertCoordinates.convert_to_numercal_coords self.position
    new_coords = ConvertCoordinates.convert_to_numercal_coords new_position
    (current_coords[0] - new_coords[0]).abs == 2
  end

  def move_one_horizontally? new_position
    current_coords = ConvertCoordinates.convert_to_numercal_coords self.position
    new_coords = ConvertCoordinates.convert_to_numercal_coords new_position
    (current_coords[0] - new_coords[0]).abs == 1
  end

  def move_two_vertically? new_position
    current_coords = ConvertCoordinates.convert_to_numercal_coords self.position
    new_coords = ConvertCoordinates.convert_to_numercal_coords new_position
    (current_coords[1] - new_coords[1]).abs == 2
  end

  def move_one_vertically? new_position
    current_coords = ConvertCoordinates.convert_to_numercal_coords self.position
    new_coords = ConvertCoordinates.convert_to_numercal_coords new_position
    (current_coords[1] - new_coords[1]).abs == 1
  end

end
