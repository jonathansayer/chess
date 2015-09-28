class AddBishopIdToBoard < ActiveRecord::Migration
  def change
    add_reference :boards, :bishop, index: true, foreign_key: true
  end
end
