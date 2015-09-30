class RemoveColourColumns < ActiveRecord::Migration
  def change

    remove_column :pawns, :colour, :string
    remove_column :rooks, :colour, :string
    remove_column :bishops, :colour, :string
    remove_column :knights, :colour, :string
    remove_column :kings, :colour, :string
    remove_column :queens, :colour, :string
  end
end
