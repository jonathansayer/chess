class RemoveMovementColumnsFromPawn < ActiveRecord::Migration
  def change
    remove_column :pawns, :horizontal?, :boolean
    remove_column :pawns, :vertical?, :boolean
    remove_column :pawns, :diagonal?, :boolean
    remove_column :pawns, :move_limit, :boolean
  end
end
