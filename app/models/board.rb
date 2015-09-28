class Board < ActiveRecord::Base
  has_many :pawns
  has_many :rooks
  has_many :bishops
  has_many :knights
  has_many :kings
  has_many :queens
  has_many :cells

  def move_piece piece, new_position
    old_position = piece.position
    piece.move_to new_position
    to_cell = Cell.find_by(position: new_position)
    to_cell.change_occupied_mode
    from_cell = Cell.find_by(position: old_position)
    p from_cell
    from_cell.change_occupied_mode
  end

end
