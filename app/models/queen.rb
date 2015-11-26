class Queen < ActiveRecord::Base
  belongs_to :board

  def move_to new_position
    @new_position = new_position
    raise "Invalid Move" unless possible_move?
    self.position = @new_position
  end

  def possible_move?
    return false unless !piece_in_path?
    horizonatal_move? or vertical_move? or diagonal_move?
  end

  private

    def horizonatal_move?
      new_coords[1] == current_coords[1]
    end

    def vertical_move?
      new_coords[0] == current_coords[0]
    end

    def diagonal_move?
      ((current_coords[0] - new_coords[0]).abs == (current_coords[1] - new_coords[1]).abs)
    end

    def current_coords
      current_coords = ConvertCoordinates.to_numerical_coords self.position
    end

    def new_coords
      new_coords = ConvertCoordinates.to_numerical_coords @new_position
    end

    def piece_in_path?
      return true if vertical_move? and piece_in_range?(1)
      return true if horizonatal_move? and piece_in_range?(0)
      return true if diagonal_move? and pieces_on_diagonal_path?
      false
    end

    def piece_in_range? index
      coordinates = current_coords
      range(index).each do |coord|
        coordinates[index] = coord
        path_position = ConvertCoordinates.to_alphabetical_coords coordinates
        if path_position != self.position and path_position != @new_position
          return true if Cell.find_by(position: path_position).occupied?
        end
      end
      false
    end

    def pieces_on_diagonal_path?
      index = 0
      loop do
        break if range(0)[index] == nil or range(1)[index] == nil
        piece_position_path = ConvertCoordinates.to_alphabetical_coords [range(0)[index], range(1)[index]]
        index += 1
        cell = Cell.find_by(position: piece_position_path)
        if cell.position != self.position and cell != @new_position
          return true if cell.occupied?
        end
      end
      false
    end

    def range index
      coordinates_in_path = (current_coords[index]..new_coords[index]).to_a
        if current_coords[index] > new_coords[index]
          coordinates_in_path = current_coords[index].downto(new_coords[index]).to_a
        end
      coordinates_in_path
    end

end
