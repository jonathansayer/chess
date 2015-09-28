class AddRooksToBoard < ActiveRecord::Migration
  def change
    add_reference :boards, :rook, index: true, foreign_key: true
  end
end
