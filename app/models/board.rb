class Board < ActiveRecord::Base
  has_many :pawns
  has_many :rooks
  has_many :bishops
  has_many :knights
  has_many :kings
  has_many :queens
  has_many :cells

  def move_piece piece, new_position
    @piece = piece
    old_position = piece.position
    piece.move_to new_position
    occupy_cell_at new_position
    leave_cell_at old_position
  end

  def in_check?
    white_in_check? or black_in_check?
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
    if Pawn.exists?(position: new_position, white?: !@piece.white?)
      removed_piece = Pawn.where(position: new_position, white?: !@piece.white?).first
    elsif Rook.exists?(position: new_position, white?: !@piece.white?)
      removed_piece = Rook.where(position: new_position, white?: !@piece.white?).first
    elsif Bishop.exists?(position: new_position, white?: !@piece.white?)
      removed_piece = Bishop.where(position: new_position, white?: !@piece.white?).first
    elsif Knight.exists?(position: new_position, white?: !@piece.white?)
      removed_piece = Knight.where(position: new_position, white?: !@piece.white?).first
    elsif Queen.exists?(position: new_position, white?: !@piece.white?)
      removed_piece = Queen.where(position: new_position, white?: !@piece.white?).first
    elsif King.exists?(position: new_position, white?: !@piece.white?)
      removed_piece = King.where(position: new_position, white?: !@piece.white?).first
    else
      raise 'Invalid Move'
    end
    removed_piece.update_column("position", "Off Board")
  end

  def white_in_check?
    white_king = King.where(white?: true).first
    pawns = Pawn.where(white?: false)
    rooks = Rook.where(white?: false)
    knights = Knight.where(white?: false)
    bishops = Bishop.where(white?: false)
    queen = Queen.where(white?: false)
    king = King.where(white?: false)
    opponent_pieces = pawns + rooks + knights + bishops + queen + king
    opponent_pieces.each do |piece|
      return true if piece.possible_move? white_king.position
    end
    return false
  end

  def black_in_check?
    black_king = King.where(white?: false).first
    pawns = Pawn.where(white?: true)
    rooks = Rook.where(white?: true)
    knights = Knight.where(white?: true)
    bishops = Bishop.where(white?: true)
    queen = Queen.where(white?: true)
    king = King.where(white?: true)
    opponent_pieces = pawns + rooks + knights + bishops + queen + king
    opponent_pieces.each do |piece|
      return true if piece.possible_move? black_king.position
    end
    return false
  end

end
