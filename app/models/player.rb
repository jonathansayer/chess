class Player < ActiveRecord::Base

  belongs_to :board
  attr_reader :colour
  attr_accessor :status

  def initialize colour
    @colour = colour
    @status = "playing"
    Board.create
  end

  def move piece, position, board = Board.first
    board.move_piece piece, position
  end

  def win
    @status = 'Winner'
  end

  def lose
    @status = 'You Lost!'
  end
end
