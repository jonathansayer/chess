class AddKingIdToBoard < ActiveRecord::Migration
  def change
    add_reference :boards, :king, index: true, foreign_key: true
  end
end
