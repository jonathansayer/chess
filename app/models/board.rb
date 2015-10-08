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

  def in_check? colour
    is_white = false
    if colour == 'white'
      is_white = true
    end
    checked_king = King.where(white?: is_white).first
    pawns = Pawn.where(white?: !is_white)
    rooks = Rook.where(white?: !is_white)
    knights = Knight.where(white?: !is_white)
    bishops = Bishop.where(white?: !is_white)
    queen = Queen.where(white?: !is_white)
    king = King.where(white?: !is_white)
    opponent_pieces = pawns + rooks + knights + bishops + queen + king
    opponent_pieces.each do |piece|
      return true if piece.possible_move? checked_king.position
    end
    return false
  end

  def check_mate? colour
    is_white = false
    if colour == 'white'
      is_white = true
    end
    return false if is_white and !in_check?('white')
    return false if !is_white and !in_check?('black')
    king = King.where(white?: is_white).first
    original_position = king.position
    king.all_possible_moves.each do |possible_move|
      king.position = possible_move
      if (is_white and !in_check?('white')) or (!is_white and !in_check?('black'))
        king.position = original_position
        return false
      end
    end
    return true
  end

  private

  def occupy_cell_at new_position
    to_cell = Cell.find_by(position: new_position)
    remove_piece new_position if to_cell.occupied? == true
    to_cell.change_occupied_mode if to_cell.occupied? == false
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
    removed_piece.destroy
  end
end
