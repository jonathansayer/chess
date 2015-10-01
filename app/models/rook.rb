class Rook < ActiveRecord::Base
  belongs_to :board

  def move_to new_position
    @new_position = new_position
    raise "Invalid Move" unless possible_move?
    self.position = @new_position
  end

  def possible_move?
    return false unless horizonatal_move? or vertical_move?
    return false if piece_in_path?
    return true
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

  def piece_in_path?
    return true if piece_in_the_y_range? and vertical_move?
    return true if piece_in_the_x_range? and horizonatal_move?
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
