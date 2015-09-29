class Rook < ActiveRecord::Base
  belongs_to :board

  def move_to new_position
    raise "Invalid Move" unless horizonatal_move? new_position or vertical_move? new_position
    p piece_in_path? new_position
    raise "Invalid Move" if piece_in_path? new_position
    self.position = new_position
  end

  private

  def horizonatal_move? new_position
      current_coords = ConvertCoordinates.convert_to_numercal_coords self.position
      new_coords = ConvertCoordinates.convert_to_numercal_coords new_position
      return new_coords[1] == current_coords[1]
  end

  def vertical_move? new_position
    current_coords = ConvertCoordinates.convert_to_numercal_coords self.position
    new_coords = ConvertCoordinates.convert_to_numercal_coords new_position
    return new_coords[0] == current_coords[0]
  end

  def piece_in_path? new_position
    path_coords = ConvertCoordinates.convert_to_numercal_coords self.position, new_position
    y_range = ((path_coords.first[1]+1)...path_coords.last[1])
    y_range.each do |y_coord|
      path_position = ConvertCoordinates.convert_to_alphabetical_coords [path_coords.first[0],y_coord]
      return true if Cell.find_by(position: path_position).occupied?
    end
    return false
  end
end
