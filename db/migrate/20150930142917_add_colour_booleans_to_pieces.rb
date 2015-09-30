class AddColourBooleansToPieces < ActiveRecord::Migration
  def change
    add_column :pawns, :white?, :boolean
    add_column :rooks, :white?, :boolean
    add_column :bishops, :white?, :boolean
    add_column :knights, :white?, :boolean
    add_column :kings, :white?, :boolean
    add_column :queens, :white?, :boolean
  end
end
