class Pawn < ActiveRecord::Base
  belongs_to :board

  def move_to new_position
    raise "Invalid Move" unless possible_move? new_position
    self.position = new_position
  end

  def possible_move? new_position
    @new_position = new_position
    return false if invalid_move?
    return true
  end

  private

  def invalid_move?
    convert_to_and_from_coordinates
    return true unless (vertical_move? or diagonal_move?)
    return true if cell_infront_occupied? and !diagonal_move?
  end

  def convert_to_and_from_coordinates
    @cell_in_front_position = ConvertCoordinates.to_alphabetical_coords [current_coords[0], current_coords[1]+1]
  end

  def vertical_move?
    return false if new_coords[1] - current_coords[1] > move_limit
    return new_coords[0] == current_coords[0]
  end

  def diagonal_move?
    return false if new_coords[0] - current_coords[0] > 1
    return false if Cell.find_by(position: @new_position).occupied? == false
    return ((current_coords[0] - new_coords[0]).abs == (current_coords[1] - new_coords[1]).abs)
  end

  def move_limit
    return 2 if current_coords[1] == 2
    return 1
  end

  def cell_infront_occupied?
    return true if Cell.find_by(position: @cell_in_front_position).occupied?
    return true if Cell.find_by(position: @new_position).occupied? and vertical_move?
  end

  def current_coords
    ConvertCoordinates.to_numerical_coords self.position
  end

  def new_coords
    ConvertCoordinates.to_numerical_coords @new_position
  end
end
