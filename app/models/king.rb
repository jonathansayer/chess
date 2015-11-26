class King < ActiveRecord::Base
  belongs_to :board

  def move_to new_position
    @new_position = new_position
    raise "Invalid Move" unless possible_move?
    self.position = new_position
  end

  def all_possible_moves
    determine_possible_moves(possible_moves = [])
    possible_moves
  end

  def possible_move?
    return false unless @new_position != self.position
    true if move_in_dimension?(1) or move_in_dimension?(0) or diagonal_move?
  end

  private

  def determine_possible_moves array
    Cell.all.each do |cell|
      @new_position = cell.position
      array.push(cell.position) if possible_move?
    end
  end

  def move_in_dimension? index
    i = 0
    i = 1 if index == 0
    return false if move_length(i) > 1
    new_coords[index] == current_coords[index]
  end

  def diagonal_move?
    return false if move_length(0) > 1 or move_length(1) > 1
    move_length(0) == move_length(1)
  end

  def move_length index
    (current_coords[index] - new_coords[index]).abs
  end

  def current_coords
    current_coords = ConvertCoordinates.to_numerical_coords self.position
  end

  def new_coords
    new_coords = ConvertCoordinates.to_numerical_coords @new_position
  end
end
