class King < ActiveRecord::Base
  belongs_to :board

  def move_to new_position
    @new_position = new_position
    raise "Invalid Move" unless possible_move?
    self.position = new_position
  end

  def all_possible_moves
    possible_moves = []
    cells = Cell.all
    cells.each do |cell|
      @new_position = cell.position
      possible_moves.push(cell.position) if possible_move?
    end
    possible_moves
  end

  private

  def possible_move?
    return true if horizonatal_move? or vertical_move? or diagonal_move?
    return false
  end

  def horizonatal_move?
      return false if (new_coords[0] - current_coords[0]).abs > move_limit
      return new_coords[1] == current_coords[1]
  end

  def vertical_move?
    return false if (new_coords[1] - current_coords[1]).abs > move_limit
    return new_coords[0] == current_coords[0]
  end

  def diagonal_move?
    return false if (new_coords[0] - current_coords[0]).abs > 1 or (new_coords[1] - current_coords[1]).abs > 1
    return ((current_coords[0] - new_coords[0]).abs == (current_coords[1] - new_coords[1]).abs)
  end

  def move_limit
    1
  end

  def current_coords
    current_coords = ConvertCoordinates.to_numerical_coords self.position
  end

  def new_coords
    new_coords = ConvertCoordinates.to_numerical_coords @new_position
  end
end
