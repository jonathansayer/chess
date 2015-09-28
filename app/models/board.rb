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
    occupy_cell_at new_position
    leave_cell_at old_position
  end

  private

  def occupy_cell_at new_position
    to_cell = Cell.find_by(position: new_position)
    to_cell.change_occupied_mode if to_cell.occupied? == false
    remove_piece new_position if to_cell.occupied? == true
  end

  def leave_cell_at old_position
    from_cell = Cell.find_by(position: old_position)
    from_cell.change_occupied_mode
  end

  def remove_piece new_position
    if Pawn.exists?(position: new_position)
      removed_piece = Pawn.where(position: new_position).first
    elsif Rook.exists?(position: new_position)
      removed_piece = Rook.where(position: new_position).first
    elsif Bishop.exists?(position: new_position)
      removed_piece = Bishop.where(position: new_position).first
    elsif Knight.exists?(position: new_position)
      removed_piece = Knight.where(position: new_position).first
    elsif Queen.exists?(position: new_position)
      removed_piece = Queen.where(position: new_position).first
    elsif King.exists?(position: new_position)
      removed_piece = King.where(position: new_position).first
    end
    removed_piece.update_column("position", "Off Board")
  end

end
