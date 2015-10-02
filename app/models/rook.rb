class Rook < ActiveRecord::Base
  belongs_to :board

  def move_to new_position
    raise "Invalid Move" unless possible_move? new_position
    self.position = @new_position
  end

  def possible_move? new_position
    @new_position = new_position
    return false unless horizonatal_move? or vertical_move?
    return false if piece_in_path?
    return true
  end

  private

  def horizonatal_move?
    return new_coords[1] == current_coords[1]
  end

  def vertical_move?
    return new_coords[0] == current_coords[0]
  end

  def current_coords
    current_coords = ConvertCoordinates.to_numercal_coords self.position
  end

  def new_coords
    new_coords = ConvertCoordinates.to_numercal_coords @new_position
  end

  def piece_in_path?
    return true if piece_in_the_y_range? and vertical_move?
    return true if piece_in_the_x_range? and horizonatal_move?
    return false
  end

  def piece_in_the_y_range?
    y_range.each do |y_coord|
      path_position = ConvertCoordinates.to_alphabetical_coords [current_coords[0],y_coord]
      if path_position != self.position and path_position != @new_position
        return true if Cell.find_by(position: path_position).occupied?
      end
    end
    return false
  end

  def piece_in_the_x_range?
    x_range.each do |x_coord|
      path_position = ConvertCoordinates.to_alphabetical_coords [x_coord,current_coords[1]]
      if path_position != self.position and path_position != @new_position
        return true if Cell.find_by(position: path_position).occupied?
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
