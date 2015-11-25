class Pawn < ActiveRecord::Base
  belongs_to :board

  def move_to new_position
    raise "Invalid Move" unless possible_move? new_position
    self.position = new_position
  end

  def possible_move? new_position
    @new_position = new_position
    !invalid_move?
  end

  private

  def invalid_move?
    convert_to_and_from_coordinates
    return true unless (vertical_move? or diagonal_move?)
    true if cell_infront_occupied? and !diagonal_move?
  end

  def convert_to_and_from_coordinates
    @cell_in_front_position = ConvertCoordinates.to_alphabetical_coords [current_coords[0], current_coords[1]+1]
  end

  def vertical_move?
    return false unless move_length(1) <= move_limit
    new_coords[0] == current_coords[0]
  end

  def diagonal_move?
    return false unless move_length(0) <= 1
    return false unless Cell.find_by(position: @new_position).occupied? == true
    move_length(0) == move_length(1)
  end

  def move_limit
    return 1 unless current_coords[1] == 2
    2
  end

  def cell_infront_occupied?
    in_front = Cell.find_by(position: @cell_in_front_position)
    new_position = Cell.find_by(position: @new_position)
    true if in_front.occupied? or (new_position.occupied? and vertical_move?)
  end

  def current_coords
    ConvertCoordinates.to_numerical_coords self.position
  end

  def new_coords
    ConvertCoordinates.to_numerical_coords @new_position
  end

  def move_length index
    new_coords[index] - current_coords[index]
  end
end
