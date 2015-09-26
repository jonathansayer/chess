class Pawn < ActiveRecord::Base

  def move_forward number
    coords = ConvertCoordinates.convert_to_numercal_coords position
    raise "Invalid Move" if coords[1] != 2 and number == 2
    coords[1] += number
    new_position = ConvertCoordinates.convert_to_alphabetical_coords coords
    self.position = new_position
  end

  def move_diagonally new_position
    @coords = ConvertCoordinates.convert_to_numercal_coords position
    @new_coords = ConvertCoordinates.convert_to_numercal_coords new_position
    raise_error_if_invalid new_position
    self.position = ConvertCoordinates.convert_to_alphabetical_coords @new_coords
  end

  private

  def raise_error_if_invalid new_position
    raise 'Invalid Move' if (@new_coords[1] - @coords[1]) > 1 or (@coords[1] - @new_coords[1]) > 1
    raise 'Invalid Move' if Cell.find_by(position: new_position).occupied? == false
  end

end
