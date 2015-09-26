class Pawn < ActiveRecord::Base

  def move_forward
    coords = ConvertCoordinates.convert_to_numercal_coords position
    coords[1] += 1
    new_position = ConvertCoordinates.convert_to_alphabetical_coords coords
    self.position = new_position
  end

  def move_two_squares
    coords = ConvertCoordinates.convert_to_numercal_coords position
    raise "Invalid Move" if coords[1] != 2
    coords[1] += 2
    new_position = ConvertCoordinates.convert_to_alphabetical_coords coords
    self.position = new_position
  end

  def move_diagonally new_position
    coords = ConvertCoordinates.convert_to_numercal_coords position
    new_coords = ConvertCoordinates.convert_to_numercal_coords new_position
    raise "Invalid Move" if (new_coords[1] - coords[1]) > 1 or (coords[1] - new_coords[1]) > 1
    raise 'Invalid Move' if Cell.find_by(position: new_position).occupied? == false
    coords = new_coords
    new_position = ConvertCoordinates.convert_to_alphabetical_coords coords
    self.position = new_position
  end

end
