class AddColoursToPieces < ActiveRecord::Migration
  def change
    add_column :pawns, :colour, :string
    add_column :rooks, :colour, :string
    add_column :bishops, :colour, :string
    add_column :knights, :colour, :string
    add_column :kings, :colour, :string
    add_column :queens, :colour, :string

  end
end
