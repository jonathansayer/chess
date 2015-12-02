class Player < ActiveRecord::Base

  belongs_to :board

  def move piece, position, board = Board.first
    board.move_piece piece, position
  end

  def win
    self.status = 'Winner'
  end

  def lose
    self.status = 'You Lost!'
  end
end
