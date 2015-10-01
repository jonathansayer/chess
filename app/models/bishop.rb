class Bishop < ActiveRecord::Base
  belongs_to :board

  def move_to new_position
    @new_position = new_position
    raise 'Invalid Move' unless possible_move?
    self.position = new_position
  end

  def possible_move?
    return false if invalid_move?
    return true
  end

  private

  def invalid_move?
    return true unless diagonal_move? and !any_pieces_on_path?
    return false
  end

  def diagonal_move?
    return ((current_coords[0] - new_coords[0]).abs == (current_coords[1] - new_coords[1]).abs)
  end

  def current_coords
    current_coords = ConvertCoordinates.to_numercal_coords self.position
  end

  def new_coords
    new_coords = ConvertCoordinates.to_numercal_coords @new_position
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
    return false
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
end
