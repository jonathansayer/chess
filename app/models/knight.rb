class Knight < ActiveRecord::Base
  belongs_to :board

  def move_to new_position
    @new_position = new_position
    raise 'Invalid Move' unless possible_move?
    self.position = new_position
  end

  def possible_move?
    (move_two_horizontally? and move_one_vertically?) or (move_two_vertically? and move_one_horizontally?)
  end

  private

  def move_two_horizontally?
    current_coords = ConvertCoordinates.convert_to_numercal_coords self.position
    new_coords = ConvertCoordinates.convert_to_numercal_coords @new_position
    (current_coords[0] - new_coords[0]).abs == 2
  end

  def move_one_horizontally?
    current_coords = ConvertCoordinates.convert_to_numercal_coords self.position
    new_coords = ConvertCoordinates.convert_to_numercal_coords @new_position
    (current_coords[0] - new_coords[0]).abs == 1
  end

  def move_two_vertically?
    current_coords = ConvertCoordinates.convert_to_numercal_coords self.position
    new_coords = ConvertCoordinates.convert_to_numercal_coords @new_position
    (current_coords[1] - new_coords[1]).abs == 2
  end

  def move_one_vertically?
    current_coords = ConvertCoordinates.convert_to_numercal_coords self.position
    new_coords = ConvertCoordinates.convert_to_numercal_coords @new_position
    (current_coords[1] - new_coords[1]).abs == 1
  end

end
