class Rook < ActiveRecord::Base
  belongs_to :board

  def move_to new_position
    raise "Invalid Move" unless possible_move? new_position
    self.position = @new_position
  end

  def possible_move? new_position
    @new_position = new_position
    return false unless (horizontal_or_vertical_move?) and !piece_in_path?
    true
  end

  private

  def horizontal_or_vertical_move?
    new_coords[0] == current_coords[0] or new_coords[1] == current_coords[1]
  end

  def current_coords
    current_coords = ConvertCoordinates.to_numerical_coords self.position
  end

  def new_coords
    new_coords = ConvertCoordinates.to_numerical_coords @new_position
  end

  def piece_in_path?
    true if (piece_in_range?(1) or piece_in_range?(0)) and horizontal_or_vertical_move?
  end

  def piece_in_range? index
    range_in(index).each do |coord|
      return true if piece_on_cell?(coord, index) == true
    end
    false
  end

  def piece_on_cell? coord, index
    coordinates = current_coords
    coordinates[index] = coord
    path_position = ConvertCoordinates.to_alphabetical_coords coordinates
    if not_end_of_path? path_position
      return true if Cell.find_by(position: path_position).occupied?
    end
  end

  def not_end_of_path? path_position
    path_position != self.position and path_position != @new_position
  end

  def range_in index
    coordinates_in_path = ((current_coords[index])..new_coords[index]).to_a
    if current_coords[index] > new_coords[index]
      coordinates_in_path = current_coords[index].downto(new_coords[index]).to_a
    end
    coordinates_in_path
  end

end
