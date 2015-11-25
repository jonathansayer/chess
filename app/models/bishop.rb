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
      break if x_range[index] == nil or y_range[index] == nil
      piece_position_path = ConvertCoordinates.to_alphabetical_coords [x_range[index], y_range[index]]
      index += 1
      cell = Cell.find_by(position: piece_position_path)
      if cell.position != self.position and cell != @new_position
        return true if cell.occupied?
      end
    end
  end

  def x_range
    x_coordinates_in_path = ((current_coords[0])..new_coords[0]).to_a
    if current_coords[0] > new_coords[0]
      x_coordinates_in_path = current_coords[0].downto(new_coords[0]).to_a
    end
    return x_coordinates_in_path
  end

  def y_range
    y_coordinates_in_path = ((current_coords[1])..new_coords[1]).to_a
    if current_coords[1] > new_coords[1]
      y_coordinates_in_path = current_coords[1].downto(new_coords[1]).to_a
    end
    return y_coordinates_in_path
  end

  def move_length index
    (current_coords[index] - new_coords[index]).abs
  end

end
