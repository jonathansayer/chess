class Rook < ActiveRecord::Base

  def move_to new_position
    raise "Invalid Move" unless horizonatal_move? new_position or vertical_move? new_position
    self.position = new_position
  end

  private

  def horizonatal_move? new_position
      current_coords = ConvertCoordinates.convert_to_numercal_coords self.position
      new_coords = ConvertCoordinates.convert_to_numercal_coords new_position
      return new_coords[1] == current_coords[1]
  end

  def vertical_move? new_position
    current_coords = ConvertCoordinates.convert_to_numercal_coords self.position
    new_coords = ConvertCoordinates.convert_to_numercal_coords new_position
    return new_coords[0] == current_coords[0]
  end
end
