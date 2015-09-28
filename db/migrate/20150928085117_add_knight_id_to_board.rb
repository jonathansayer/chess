class AddKnightIdToBoard < ActiveRecord::Migration
  def change
    add_reference :boards, :knight, index: true, foreign_key: true
  end
end
