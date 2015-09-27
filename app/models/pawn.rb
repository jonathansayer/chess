class Pawn < ActiveRecord::Base

  def move_to new_position
    raise "Invalid Move" unless (vertical_move? new_position or diagonal_move? new_position)
    self.position = new_position
  end

  private
  
  def vertical_move? new_position
    current_coords = ConvertCoordinates.convert_to_numercal_coords self.position
    new_coords = ConvertCoordinates.convert_to_numercal_coords new_position
    return false if new_coords[1] - current_coords[1] > move_limit
    return new_coords[0] == current_coords[0]
  end

  def move_limit
    current_coords =  ConvertCoordinates.convert_to_numercal_coords self.position
    return 2 if current_coords[1] == 2
    return 1
  end

  def diagonal_move? new_position
    current_coords = ConvertCoordinates.convert_to_numercal_coords self.position
    new_coords = ConvertCoordinates.convert_to_numercal_coords new_position
    return false if new_coords[0] - current_coords[0] > 1
    return false if Cell.find_by(position: new_position).occupied? == false
    return ((current_coords[0] - new_coords[0]).abs == (current_coords[1] - new_coords[1]).abs)
  end
end
