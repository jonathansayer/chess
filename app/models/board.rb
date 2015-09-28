class Board < ActiveRecord::Base
  has_many :pawns
  has_many :rooks
  has_many :bishops
  has_many :knights
  has_many :kings
  has_many :queens
  has_many :cells

  def move_piece piece, new_position
    piece.move_to new_position
    cell = Cell.find_by(position: new_position)
    cell.change_occupied_mode
  end

end
