class Bishop < ActiveRecord::Base
  belongs_to :board

  def move_to new_position
    raise 'Invalid Move' if invalid_move? new_position
    self.position = new_position
  end

  private

  def diagonal_move? new_position
    current_coords = ConvertCoordinates.convert_to_numercal_coords self.position
    new_coords = ConvertCoordinates.convert_to_numercal_coords new_position
    return ((current_coords[0] - new_coords[0]).abs == (current_coords[1] - new_coords[1]).abs)
  end

  def invalid_move? new_position
    piece_path = ConvertCoordinates.convert_to_numercal_coords self.position, new_position
    x_range = ((piece_path.first[0])..piece_path.last[0]).to_a
    if piece_path.first[0] > piece_path.last[0]
      x_range = piece_path.first[0].downto(piece_path.last[0]).to_a
    end
    y_range = ((piece_path.first[1])..piece_path.last[1]).to_a
    if piece_path.first[1] > piece_path.last[1]
      y_range = piece_path.first[1].downto(piece_path.last[1]).to_a
    end
    index = 0
    loop do
      break if x_range[index] == nil or y_range[index] == nil
      position_path = ConvertCoordinates.convert_to_alphabetical_coords [x_range[index], y_range[index]]
      index += 1
      cell = Cell.find_by(position: position_path)
      if cell.position != self.position and cell != new_position
        return true if cell.occupied?
      end
    end
    return true unless diagonal_move? new_position
    return false
  end

end
