class Pawn < ActiveRecord::Base
  belongs_to :board

  def move_to new_position
    raise "Invalid Move" if invalid_move? new_position
    self.position = new_position
  end

  private

  def invalid_move? new_position
    convert_to_and_from_coordinates new_position
    return true unless (vertical_move? new_position or diagonal_move? new_position)
    return true if cell_infront_occupied? new_position
  end

  def convert_to_and_from_coordinates new_position
    @current_coords = ConvertCoordinates.convert_to_numercal_coords self.position
    @new_coords = ConvertCoordinates.convert_to_numercal_coords new_position
    @cell_in_front_position = ConvertCoordinates.convert_to_alphabetical_coords [@current_coords[0], @current_coords[1]+1]
  end

  def vertical_move? new_position
    return false if @new_coords[1] - @current_coords[1] > move_limit
    return @new_coords[0] == @current_coords[0]
  end

  def diagonal_move? new_position
    return false if @new_coords[0] - @current_coords[0] > 1
    return false if Cell.find_by(position: new_position).occupied? == false
    return ((@current_coords[0] - @new_coords[0]).abs == (@current_coords[1] - @new_coords[1]).abs)
  end

  def move_limit
    return 2 if @current_coords[1] == 2
    return 1
  end

  def cell_infront_occupied? new_position
    return true if Cell.find_by(position: @cell_in_front_position).occupied?
    return true if Cell.find_by(position: new_position).occupied? and vertical_move? new_position
  end
end
