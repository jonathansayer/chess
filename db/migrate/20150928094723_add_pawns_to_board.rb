class AddPawnsToBoard < ActiveRecord::Migration
  def change
    add_reference :boards, :pawn, index: true, foreign_key: true
  end
end
