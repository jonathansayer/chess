class Queen < ActiveRecord::Base
  belongs_to :board

  def move_to new_position
    @new_position = new_position
    raise "Invalid Move" unless horizonatal_move? or vertical_move? or diagonal_move?
    raise 'Invalid Move' if piece_in_path?
    self.position = new_position
  end

  private

    def horizonatal_move?
        current_coords = ConvertCoordinates.convert_to_numercal_coords self.position
        new_coords = ConvertCoordinates.convert_to_numercal_coords @new_position
        return new_coords[1] == current_coords[1]
    end

    def vertical_move?
      current_coords = ConvertCoordinates.convert_to_numercal_coords self.position
      new_coords = ConvertCoordinates.convert_to_numercal_coords @new_position
      return new_coords[0] == current_coords[0]
    end

    def diagonal_move?
      current_coords = ConvertCoordinates.convert_to_numercal_coords self.position
      new_coords = ConvertCoordinates.convert_to_numercal_coords @new_position
      return ((current_coords[0] - new_coords[0]).abs == (current_coords[1] - new_coords[1]).abs)
    end

    def piece_in_path?
      return true if vertical_move? and piece_in_the_y_range?
      return true if horizonatal_move? and piece_in_the_x_range?
      return true if diagonal_move? and pieces_on_diagonal_path?
      return false
    end

    def piece_in_the_y_range?
      piece_coords_path = ConvertCoordinates.convert_to_numercal_coords self.position, @new_position
      y_range.each do |y_coord|
        path_position = ConvertCoordinates.convert_to_alphabetical_coords [piece_coords_path.first[0],y_coord]
        if path_position != self.position and path_position != @new_position
          return true if Cell.find_by(position: path_position).occupied?
        end
      end
      return false
    end

    def piece_in_the_x_range?
      piece_coords_path = ConvertCoordinates.convert_to_numercal_coords self.position, @new_position
      x_range.each do |x_coord|
        path_position = ConvertCoordinates.convert_to_alphabetical_coords [x_coord,piece_coords_path.first[1]]
        if path_position != self.position and path_position != @new_position
          return true if Cell.find_by(position: path_position).occupied?
        end
      end
      return false
    end

    def pieces_on_diagonal_path?
      index = 0
      loop do
        break if x_range[index] == nil or y_range[index] == nil
        piece_position_path = ConvertCoordinates.convert_to_alphabetical_coords [x_range[index], y_range[index]]
        index += 1
        cell = Cell.find_by(position: piece_position_path)
        if cell.position != self.position and cell != @new_position
          return true if cell.occupied?
        end
      end
      return false
    end

    def x_range
      piece_coords_path = ConvertCoordinates.convert_to_numercal_coords self.position, @new_position
      x_coordinates_in_path = ((piece_coords_path.first[0])..piece_coords_path.last[0]).to_a
      if piece_coords_path.first[0] > piece_coords_path.last[0]
        x_coordinates_in_path = piece_coords_path.first[0].downto(piece_coords_path.last[0]).to_a
      end
      return x_coordinates_in_path
    end

    def y_range
      piece_coords_path = ConvertCoordinates.convert_to_numercal_coords self.position, @new_position
      y_coordinates_in_path = ((piece_coords_path.first[1])..piece_coords_path.last[1]).to_a
      if piece_coords_path.first[1] > piece_coords_path.last[1]
        y_coordinates_in_path = piece_coords_path.first[1].downto(piece_coords_path.last[1]).to_a
      end
      return y_coordinates_in_path
    end


end
