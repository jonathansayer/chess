class AddQueensToBoard < ActiveRecord::Migration
  def change
    add_reference :boards, :queen, index: true, foreign_key: true
  end
end
