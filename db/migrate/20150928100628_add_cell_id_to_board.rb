class AddCellIdToBoard < ActiveRecord::Migration
  def change
    add_reference :boards, :cell, index: true, foreign_key: true
  end
end
