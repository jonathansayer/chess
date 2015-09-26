class Pawn < ActiveRecord::Base

  attr_reader:allowed_directions

  def direction
    'forward'
  end

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

end
