class King < ActiveRecord::Base
  belongs_to :board

  def move_to new_position
    @new_position = new_position
    raise "Invalid Move" unless possible_move?
    self.position = new_position
  end

  def possible_move?
    return true if horizonatal_move? or vertical_move? or diagonal_move?
  end

  private

  def horizonatal_move?
      current_coords = ConvertCoordinates.to_numercal_coords self.position
      new_coords = ConvertCoordinates.to_numercal_coords @new_position
      return false if (new_coords[0] - current_coords[0]).abs > move_limit
      return new_coords[1] == current_coords[1]
  end

  def vertical_move?
    current_coords = ConvertCoordinates.to_numercal_coords self.position
    new_coords = ConvertCoordinates.to_numercal_coords @new_position
    return false if (new_coords[1] - current_coords[1]).abs > move_limit
    return new_coords[0] == current_coords[0]
  end

  def diagonal_move?
    current_coords = ConvertCoordinates.to_numercal_coords self.position
    new_coords = ConvertCoordinates.to_numercal_coords @new_position
    return false if (new_coords[0] - current_coords[0]).abs > 1 or (new_coords[1] - current_coords[1]).abs > 1
    return ((current_coords[0] - new_coords[0]).abs == (current_coords[1] - new_coords[1]).abs)
  end

  def move_limit
    1
  end

end
