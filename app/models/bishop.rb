class Bishop < ActiveRecord::Base
  belongs_to :board

  def move_to new_position
    @new_position = new_position
    raise 'Invalid Move' unless possible_move?
    self.position = new_position
  end

  def possible_move?
    return true unless invalid_move?
  end

  private

  def invalid_move?
    return true unless diagonal_move? and !any_pieces_on_path?
  end

  def diagonal_move?
    move_length(0) == move_length(1)
  end

  def current_coords
    ConvertCoordinates.to_numerical_coords self.position
  end

  def new_coords
    ConvertCoordinates.to_numerical_coords @new_position
  end

  def any_pieces_on_path?
    index = 0
    loop do
      break if range_in('x')[index] == nil or range_in('y')[index] == nil
      piece_position_path = ConvertCoordinates.to_alphabetical_coords [range_in('x')[index], range_in('y')[index]]
      index += 1
      cell = Cell.find_by(position: piece_position_path)
      if cell.position != self.position and cell != @new_position and cell.occupied?
        return true
      end
    end
  end

  def range_in dimension
    index = 0
    index = 1 if dimension == 'y'
    coordinates_in_path = ((current_coords[index])..new_coords[index]).to_a
    if current_coords[index] > new_coords[index]
      coordinates_in_path = current_coords[index].downto(new_coords[index]).to_a
    end
    coordinates_in_path
  end

  def move_length index
    (current_coords[index] - new_coords[index]).abs
  end

end
