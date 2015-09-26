class Rook < ActiveRecord::Base

  def move_to new_position
    @current_coords = ConvertCoordinates.convert_to_numercal_coords position
    @new_coords = ConvertCoordinates.convert_to_numercal_coords new_position
    check_if_not_a_valid_move
    self.position = new_position
  end

  private

  def check_if_not_a_valid_move
    raise "Invalid Move" if @new_coords[0] != @current_coords[0] and @new_coords[1] != @current_coords[1]
  end
end
